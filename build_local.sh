#!/bin/bash
#
# Copyright The Titan Project Contributors.
#

set -ex

release=$1

while getopts ":ukb:z:d:" o; do
  case "${o}" in
    b)
      archive_url=$OPTARG
      ;;
    d)
      home_dir=$OPTARG
      ;;
    u)
      userland_only=true
      ;;
    k)
      kernel_only=true
      ;;
    z)
      zfs_versions=$OPTARG
      ;;
    *)
      usage
      ;;
  esac
done

out_dir=$home_dir/out
archive_dir=$out_dir/archive
build_dir=$out_dir/build
kernel_archive=zfs-$zfs_versions-$release.tar.gz

function archive_exists() {
  [[ -n $archive_url ]] && curl --output /dev/null --fail --silent --head $archive_url/$1
}

# Download Linux Headers
function install_packages() {
  sudo apt update -y
  sudo apt-get install -y linux-headers-$release
  sudo apt-get install -y                                                    \
    curl xz-utils                                                            \
    build-essential bc                                                       \
    autoconf automake libtool kmod                                           \
    zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev \
    libacl1-dev libaio-dev libdevmapper-dev libssl-dev libelf-dev
}

# Checkout ZFS source
function get_zfs_source() {
    if [ ! -d $home_dir/src/zfs ]; then
        git clone https://github.com/zfsonlinux/zfs.git $home_dir/src/zfs
        cd $home_dir/src/zfs
        [ -z $ZFS_VERSION ] && ZFS_VERSION=$(git describe --tags `git rev-list --tags --max-count=1`)
        git checkout $ZFS_VERSION
    fi
}

# Build ZFS
function build_zfs() {
    get_zfs_source
    sh ./autogen.sh
    ./configure \
      --prefix=/ \
      --libdir=/lib \
      --with-linux=/usr/src/linux-headers-$release \
      --with-linux-obj=/usr/src/linux-headers-$release \
      --with-config=all
    make -s -j$(nproc)
    make install DESTDIR=$build_dir
}

if archive_exists $kernel_archive; then
  echo "Archive $kernel_archive exists, skipping"
  exit 0
fi

install_packages
build_zfs

cd $build_dir
mkdir $archive_dir
tar -czf $archive_dir/$kernel_archive lib/modules || exit 1
