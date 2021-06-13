   --- Release of a Free Base Development System for SCO ----

   To help the lack of free stand-alone compilers for SCO,  I
   snooped my disks, and found the following and ftp'd all the
   stuff:

   A COFF-producing GNU Development System for SCO Xenix/Unix,
   Novell Unixware, SVR3.2/386, Linux with iBCS and so on...
   This is now available at ftp.funet.fi/pub/unix/386ix/sco/gcc.

   From the SCO Xenix version 2.3.3, also Xenix could run COFF-
   binaries, so don't be surprised if Xenix is also supported...

   The gcc version is 2.7.2. Binaries (gcc, cc1, cpp) are
   all COFF.

   The binutils (ar, as, ld,...) version number is 2.5.2.6 

   The C-library is GNU libc version 1.09 (patched for SCO Unix
   3.2.x and Xenix 2.3.[34]).

   The GNU libg++ is version 2.7.1

   The gcc-2.7.2 is a 'stand-alone' system and doesn't need the
   SCO Development System.

   This GNU Dev Sys for SCO is a Base system with termcap (GNU 1.3)
   support only. Network (TCP/IP sockets etc.) and X11 support
   libraries are missing -- but an alpha release of ncurses-1.9,
   ported for SCO, is included.


   WHAT WORKS ALREADY:

   The following program sources have successfully compiled
   with this system and seem to work too :

    - GNU gcc-2.7.2 (the included compiler)
    - GNU texinfo-3.1
    - Fred Kruse's xwpe-1.4.2 (a Borland-type IDE)
    - joe-1.0.8 editor


   WHAT SEEMS TO NOT WORK:

    - joe-2.8 (something wrong with terminal handling...)
    - floating number outputting sometimes (this a problem of
      glibc-1.09. The glibc-1.10 is promised to fix these bugs
      -- see the GNU bulletin, June -95)

   THINGS TO PORT:

    - XFree86 (could this be done without TCP/IP, using some
      socket-with-pipes emulation package?)
 

   RELATED PRODUCTS:

   Three related cross-compilers for SCO & Co. will also be released:

    - for producing DOS-go32 (DJGPP) binaries under SCO, uses the same
      binutils, 'as' and 'ld' as the native SCO compiler. The GNU gcc is
      version 2.7.2.

    - for producing DOS/OS2-emx binaries under SCO, separate binutils,
      'as' and 'ld' (*-emx) from the native SCO compiler (binutils-
      2.5.2.6, gas-2.3, ld-1.38.x). The GNU gcc is version 2.7.2. The
      RSXNT-cross-tools for Win32 development are also included.

    - for producing Win32 binaries under SCO, separate binutils,
      'as' and 'ld' (*-emx) from the native SCO compiler (binutils-
      2.5.3, gas-2.5.3). The GNU gcc is version 2.7.2.

   These can also be found at ftp.funet.fi/pub/unix/386ix/sco subdirs.

   WHAT TO DO:

    - porting of the Cygnus newlib to SCO

    - other target types that have free libs & headers available
      (= portings of glibc to different targets).
 
   Best regards,

   Kai Ruottu, karuottu@freenet.hut.fi
