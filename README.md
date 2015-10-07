# Clearwater-Specific Net-SNMP Builds

This repository automates the building of custom releases of net-snmp for
Project Clearwater.

## Building the libraries

    make

The default target for `make` will download the source for a specific version
of `net-snmp`, apply the Clearwater-specific patch and build the generated
Debian files.  These files should then be served along with the other
Clearwater Debian packages.

The `clearwater-snmpd` package will also need to be updated to depend on the
specific Clearwater release of the `net-snmp` libraries (see the
`debian/control` file in that repository for more details).

## Cleaning up

    make clean

The standard `clean` operation will reset the codebase to a clean basis.
