#!/bin/bash

# Clear out debhelper.log, so that it forgets it's already built the package
# and run 'make' again
for f in debian/*.debhelper.log
do
  sed -i -n '/dh_auto_build/q;p' $f
done

# Build the packages (-nc means 'no clean' which is what makes this an
# incremental build)
debuild --no-lintian -us -uc -nc -b
