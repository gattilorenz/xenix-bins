# Dropbear SSH for Xenix

This tree is a port of [Dropbear SSH](https://matt.ucc.asn.au/dropbear/dropbear.html)
to SCO Xenix 2.3.4 built with gcc 2.5.8 and gnu make. 
It includes binaries for:

- `dropbear` — SSH2 server, with RSA/Ed25519 host keys and RSA/Ed25519 pass & pubkey auth
- `scp` —  SCP file-transfer helper (needed for `scp`/legacy-protocol clients)

A modern OpenSSH client (tested with macOS OpenSSH, RSA-4096 client key) can be used to 
log in/transfer files.

## Installing the prebuilt binaries

Copy the include `dropbear` and `scp` binaries to `/usr/bin` (since `scp` in `/usr/local/bin`
won't work for non-interactive shells) and make sure they are executable.

Create the `/etc/dropbear` folder. Dropbear generates its own host keys on first run 
if none exist. 

Dropbear refuses pubkey auth if the user's home directory isn't privately owned. On a 
stock Xenix install, `/` (root's default home in `/etc/passwd`) is owned by `bin`, 
which fails this check. Give root a real home directory, or use another user:

```
mkdir -p /root
chown root /root
chmod 700 /root
mv /.profile /root/.profile
```
Then edit `/etc/passwd` to point root's home field at `/root` instead of `/`.

### Authorized_keys

Password authentication is enabled by default, but you can also use a public key. To do so:

```
mkdir /root/.ssh
chmod 700 /root/.ssh
```

Put the client's public key into e.g. `/root/.ssh/authorized_key`

Note the filename: it's `authorized_key` (not the more canonical `authorized_keys`) since
Xenix's filesystem will truncate anything beyond 14 characters.


### Starting the server

```
nohup /usr/bin/dropbear -F -p 2222 > /tmp/dropbear.log 2>&1 &
```

- `-F`: stay in the foreground (needed since there's no real init/daemon-fork support tested
  here; run it under `nohup &` or a supervising script instead)
- `-p 2222`: listen port

## Connecting from a modern client

Two dropbear-side limitations mean you need to pin some options on the client:

```
ssh -i ~/.ssh/id_rsa \
    -o KexAlgorithms=curve25519-sha256 \
    -o Ciphers=aes128-ctr \
    -p 2222 root@<host>
```

```
scp -O -i ~/.ssh/id_rsa \
    -o KexAlgorithms=curve25519-sha256 \
    -o Ciphers=aes128-ctr \
    -P 2222 \
    localfile root@<host>:/remote/path
```

- **`KexAlgorithms=curve25519-sha256`**: the generic NIST P-256/384/521 ECDH key exchange
  goes through libtomcrypt's generic bignum path and is unusably slow (multiple minutes 
  per handshake). Use Dropbear's dedicated Curve25519 implementation instead.
- **`Ciphers=aes128-ctr`**: `chacha20-poly1305@openssh.com` corrupts packets after the
  handshake on this build, so use AES128 instead.
- **`scp -O`**: modern OpenSSH clients default to the SFTP subsystem protocol for `scp`.
  This build does not have `sftp-server`, so force the old protocol with `-O`.

## Building from source

```
cd dropbear
gmake dropbear     # builds src/, libtommath/, libtomcrypt/, links dropbear
gmake scp          # scp is not part of the default target list, build it separately
```

A full clean build takes a few minutes on emulated period hardware. If you're doing a
clean rebuild, remove stale objects and archives first:

```
find . -print | grep '\.o$' | xargs rm -f
rm -f libtommath/libtommath.a libtomcrypt/libtomcrypt.a dropbear scp
gmake dropbear
gmake scp
```

### If the link fails with unresolved externals

`gmake`'s own incremental `ar r` step for each freshly-compiled `.o` file is unreliable on
this `ar`/filesystem combination — it can silently drop an already-compiled object from the
archive. If you see unresolved externals at link time even though the corresponding `.c`
files clearly compiled without error, rebuild the archive from every `.o` file actually on
disk:

```
cd libtomcrypt
find . -print | grep '\.o$' > /tmp/objs.txt
rm -f libtomcrypt.a
for f in `cat /tmp/objs.txt`; do ar r libtomcrypt.a $f; done
ranlib libtomcrypt.a
cd ../libtommath
# repeat for libtommath.a
cd ..
gmake dropbear
```
