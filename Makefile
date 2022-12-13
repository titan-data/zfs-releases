.PHONY: build
build:
	docker build . -t zfs-builder --build-arg S3=$(S3) --build-arg ZFS=$(ZFS) --build-arg KERNEL=$(KERNEL)
