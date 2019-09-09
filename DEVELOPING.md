# ZFS Release Development

For general information about contributing changes, see the
[Contributor Guidelines](https://github.com/titan-data/.github/blob/master/CONTRIBUTING.md).

## How it works

The information about how to build these versions is driven by the `src/`
directory that has the following layout:

   src/
      [kernel_release]/
         uname
         [config.gz | centos-release] (optional)

The kernel release should be the result of "uname -r", and the uname file should
contain the output of "uname -a". The system will mount the directory at
`/config`, so any variant-specific file contents (`centos-release`, `config.gz`,
etc) should be placed there.

The results are placed in the 'out/archive' directory. The script must be
invoked by a user with sufficient privileges to run docker containers.

## Building

The `build` script will iterate over the contents of the directory and invoke
the zfs-builder container to perform the build.

```
./build [-u] [-z zfs_version] [kernel_release ...]
```

The '-u' option will only build the userland. By default, it will build both for
the first found kernel release, and then kernel only for the remainder. The '-z'
option will specify the ZFS version(s) to build.

## Testing

You should be able to run the builds for any platforms that you are changing.
If you change the build script itself, be sure to build all of the known
platforms (this can take a while).

## Release

There is currently no automated build & release process for ZFS releases.
These must be manually built and uploaded to a GitHub release tag. The tag
must be created in a draft state prior to artifacts being uploaded, otherwise
any titan installs risk failing due to incomplete release binaries.
