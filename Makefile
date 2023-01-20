.PHONY: build image manual

image:
	docker build . -t titandata/zfs-builder-ubuntu:$(OS) -f Dockerfile-base --build-arg OS=$(OS)

manual:
	docker build . -t zfs-builder --build-arg S3=$(S3) --build-arg ZFS=$(ZFS) --build-arg KERNEL=$(KERNEL) --build-arg OS=$(OS)

build:
	docker build . -t zfs-builder --build-arg S3=$(S3) --build-arg ZFS=$(ZFS) --build-arg KERNEL=$(KERNEL)
