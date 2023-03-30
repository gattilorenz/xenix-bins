## What is this?
These are binaries compiled for SCO Unix 4.2 (ODT). I used the Compaq distribution from Archive.org. See https://virtuallyfun.com/2021/07/13/installing-sco-unix-part-1/ (and the other 2 parts) for a guide on how to install SCO Unix on 86box.

## What's included?
The names should be self explanatory, but I've compiled
- Bash 2.0 and zsh 3.1.9 and 4.0.1: because I'm lazy and I need typing completion :)
- Gcc 2.7.2.2: this version compiles right out of the box (2.8.0 doesn't, and likely requires source modifications); it's maybe not a huge improvement over 2.6.3 (available at https://archive.org/details/celestial-ftp-ports-for-unix), but it does support C++ style comments. **This version uses SCO's ld and as** (instead of gas and gnu-ld, so no GNU-isms in your asm code!).
- GNU make 3.80: slightly more recent than the version from Celestial, I'm not sure anymore _why_ I needed it, but since it's there...
- GNU sed 4.0.9: compiled with small modifications inside lib/mkstemp.c
## How to install stuff?
As with the stuff from Celestial, I included the source folder with binaries. In most cases it's a matter of running 'make install' in the extracted folder; for gcc, however, read the README_SCO file.
