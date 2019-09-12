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
./build [-u] [-k] [-z zfs_version] [kernel_release ...]
```

The '-u' option will only build userland, while '-k' will only build the kernel.
By default, it will build both for the first found kernel release, and then
kernel only for the remainder. The '-z' option will specify the ZFS version(s)
to build.

When you add a new version, you will have to update the environment
variables in .travis.yml.

## Testing

You should be able to run the builds for any platforms that you are changing.
If you change the build script itself, be sure to build all of the known
platforms (this can take a while).

## Release

We build releases on Travis, with every push triggering a new build. Once a
particular set of binaries is built, it shouldn't ever need to be updated,
so the Travis build will pass a URL via '-b' that can be used to check if
a releases exists in a S3 bucket. If it does, then the build is skipped.
Artifacts are then published to said S3 bucket.

If we do need to re-build a particular release, we can remove it manually via
the S3 console, or we could add a force flag to overwrite it if this turns out
to be a common occurrence.
