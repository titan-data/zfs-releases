FROM titandata/zfs-builder-ubuntu:22.04

ARG S3
ARG ZFS
ARG KERNEL

# Install kernel headers
RUN apt install -y linux-headers-$KERNEL

# Build ZFS Module
WORKDIR /
RUN ./build_docker.sh -b $S3 -k -z $ZFS -d /src -r $KERNEL

WORKDIR /src