**Alpenhorn** is a Docker environment for Yocto.  Built in a single Docker layer, it does not suffer the
performance penalty of other Yocto images.

When the Alpenhorn image is run, the container mounts the `build` directory of this project
on the `/build` directory of the container.  Everything that occurs in `/build` in the container is
also happening on the host, and vice versa.

Files are edited on the host; programs are run inside the Alpenhorn container.  When Bitbake is
finished, the embedded linux image (and all of the intermediate files) are on the host in the
project `build` directory.

# Quick Start
Install Docker on your machine.

```bash
export ALPENHORN_MACHINE=imx6sllevk
export ALPENHORN_DISTRO=fslc-framebuffer
export ALPENHORN_VARIANT=core-image-minimal
export ALPENHORN_BSP_URL=http://github.com/boundarydevices/boundary-bsp-platform
export ALPENHORN_BSP_BRANCH=pyro
./docker-build
./docker-run
```
The prompt you see, `[root@alpenhorn build]#`, is a shell inside a Docker container. Do not be alarmed by the root
user: the container is well isolated and your host is not in danger. You are working in directory `/build`.

```bash
source source-me-first.sh
repo_init
repo_sync
setup
bake_bits
```

Open a shell on your *host*. The embedded linux image is in a directory inside *<alpenhorn-dir>*/build.  Consult
your BSP documentation for the exact path.

# Limitations

A side effect of running as **root** inside the container is any file that is created in the container
appears on the host as owned by **root**.  A workaround is to change the ownership back to the unprivileged
user.

```bash
chown -R ${USER} build
```


