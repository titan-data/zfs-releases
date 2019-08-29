# Titan ZFS builds

This repository uses the [zfs-builder](https://github.com/delphix/zfs-builder)
image to build a set of well-known Linux ZFS binaries, for kernel and userland,
suitable for use in the titan system.

The end result of this is a set of archives:

   * zfs-[zfs_version]-userland.tar.gz
   * zfs-[zfs_version]-[kernel_release].tar.gz

## How it works

The information about how to build these versions is driven by the `src/`
directory that has the following layout:

   src/
      [kernel_release]/
         [kernel_uname]
         [config.gz] (optional)

The kernel release should be the result of "uname -r", and the uname file
should contain the output of "uname -a". This is processed by the 'build'
script, which will iterate over the contents of the directory and invoke the
zfs-builder container to perform the build.

   ./build [-u] [-z zfs_version] [kernel_release ...]

The '-u' option will only build the userland. By default, it will build both for
the first found kernel release, and then kernel only for the remainder. The '-z'
option will specify the ZFS version(s) to build.

The results are placed in the 'out/archive' directory. The script must be
invoked by a user with sufficient privileges to run docker containers.

## <a id="contribute"></a>Contribute

1.  Fork the project.
2.  Make your bug fix or new feature.
3.  Add tests for your code.
4.  Send a pull request.

Contributions must be signed as `User Name <user@email.com>`. Make sure to [set up Git with user name and email
address](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup). Bug fixes should branch from the current
stable branch. New features should be based on the `master` branch.

#### <a id="code-of-conduct"></a>Code of Conduct

This project operates under the [Delphix Code of Conduct](https://delphix.github.io/code-of-conduct.html). By
participating in this project you agree to abide by its terms.

#### <a id="contributor-agreement"></a>Contributor Agreement

All contributors are required to sign the Delphix Contributor agreement prior to contributing code to an open source
repository. This process is handled automatically by [cla-assistant](https://cla-assistant.io/). Simply open a pull
request and a bot will automatically check to see if you have signed the latest agreement. If not, you will be prompted
to do so as part of the pull request process.


## <a id="reporting_issues"></a>Reporting Issues

Issues should be reported [here](https://github.com/delphix/titan-zfs/issues).

## <a id="statement-of-support"></a>Statement of Support

This software is provided as-is, without warranty of any kind or commercial support through Delphix. See the associated
license for additional details. Questions, issues, feature requests, and contributions should be directed to the
community as outlined in the [Delphix Community Guidelines](https://delphix.github.io/community-guidelines.html).

## <a id="license"></a>License

This is code is licensed under the Apache License 2.0. Full license is available [here](./LICENSE).

