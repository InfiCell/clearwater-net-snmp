## Clearwater build instructions

To build this package from a fresh checkout, run `debuild --no-lintian -us -uc -b`.

Each time this is run, it cleans the working directory and rebuilds from scratch. To do incremental builds (e.g. if you have only made a small change), run `make` to rebuild the binaries, and then run `debuild --no-lintian -us -uc -b -nc` (where the -nc option stands for 'no clean').
