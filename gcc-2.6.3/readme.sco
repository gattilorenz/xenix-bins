---------------------------------------------------------------------
This is a COFF-producing GNU Development System for SCO Xenix/Unix,
Novell Unixware, SVR3.2/386, Linux with iBCS and so on... The gcc is
with two versions 2.5.8 and 2.6.3_e (Cygnus C++ exception handling
patches installed). The gcc-2.5.8 binaries (gcc, cc1, cpp) are OMF
(xout). But the binutils (ar, as, ld,...) and gcc-2.6.3_e are COFF.

From the version 2.3.3, also Xenix can run COFF-binaries, so don't be
surprised if Xenix is also supported here...

Why that 'old' 2.5.8 ?

This was the first gcc for the 'Free GNU Development System for SCO',
compiled with a SCO Xenix Dev Sys libraries & headers based gcc-2.5.8
(producing OMF/xout-binaries), and linked with SCO Xenix libs. So if
these SCO libc-routines work, the compiler works as well...

SCO Unix, Unixware and Linux seem to be Xenix-OMF-binary-compatible,
so this isn't a problem...

To make a working gcc with COFF-binaries, you need compiler binaries
linked with a working C-library, made of COFF-objects. I suggest you
to try one of those under SCO Unix Development System - compiled
gcc-2.6.3 packets (if available somewhere) -- until the GNU libc is
thoroughly tested and debugged to work under SCO...

I will test those newer gcc binaries, too... The gcc-2.6.3_e is,
compiled with the gcc-2.5.8 first and then with itself and then
linked with the glibc-1.09, and it seems to be working... but since
this the first release, it's good to be a little pessimistic...

Regards,

Kai Ruottu, karuottu@freenet.hut.fi
