ARG OS=22.04
FROM titandata/zfs-builder-ubuntu:$OS

ARG S3
ARG ZFS
ARG KERNEL

# Install kernel headers
RUN apt update && apt install -y linux-headers-$KERNEL

# Build ZFS Module
WORKDIR /
RUN ./build_docker.sh -b $S3 -k -z $ZFS -d /src -r $KERNEL

WORKDIR /src