# Titan ZFS builds

[![Build Status](https://travis-ci.org/titan-data/zfs-releases.svg?branch=master)](https://travis-ci.org/titan-data/zfs-releases)

This repository uses the [zfs-builder](https://github.com/titan-data/zfs-builder)
image to build a set of well-known Linux ZFS binaries, for kernel and userland,
suitable for use in the Titan project.

The end result of this is a set of archives:

   * zfs-[zfs_version]-userland.tar.gz
   * zfs-[zfs_version]-[kernel_release].tar.gz

The build process is driven by the `build` script.

## Contributing

The ZFS builder project follows the Titan community best practices:

  * [Contributing](https://github.com/titan-data/.github/blob/master/CONTRIBUTING.md)
  * [Code of Conduct](https://github.com/titan-data/.github/blob/master/CODE_OF_CONDUCT.md)
  * [Community Support](https://github.com/titan-data/.github/blob/master/SUPPORT.md)

It is maintained by the [Titan community maintainers](https://github.com/titan-data/.github/blob/master/MAINTAINERS.md)

For more information on how it works, and how to build and release new versions,
see the [Development Guidelines](DEVELOPING.md).

## License

This is code is licensed under the Apache License 2.0. Full license is
available [here](./LICENSE).
