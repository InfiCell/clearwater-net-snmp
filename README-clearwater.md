## Clearwater build instructions

To build this package from a fresh checkout, run `debuild --no-lintian -us -uc -b`. Each time this is run, it cleans the working directory and rebuilds from scratch.

To do incremental builds (e.g. if you have only made a small change), run `./incremental-build.sh` to rebuild the Debian packages with your change in.

The Debian files are created in the parent directory, e.g. `../libsnmp30_5.7.2~dfsg-clearwater4_amd64.deb`

### Build system rationale

We previously used the git-buildpackage tool and a debian/patches directory (taken from the Ubuntu snmpd source package). git-buildpackage is designed to make it easy for projects like Debian to maintain their own set of patches and apply those patches to new upstream versions they take - but net-snmp's last release was in 2014, so adding overheads to our build process to make it easy to take new versions feels like the wrong tradeoff.

Instead, we have now applied all the patches from debian/patches to the source tree, as git commits, so that the source you check out is actually the source you build.
