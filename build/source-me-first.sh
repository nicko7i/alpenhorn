#!/bin/bash

export MACHINE=${ALPENHORN_MACHINE:-imx6sllevk}
export DISTRO=${ALPENHORN_DISTRO:-fslc-framebuffer}
TARGET=${ALPENHORN_TARGET:-core-image-minimal}
BSP=${ALPENHORN_BSP_URL:-http://github.com/boundarydevices/boundary-bsp-platform}
BSP_BRANCH=${ALPENHORN_BSP_BRANCH:-pyro}

alias setup="source setup-environment ${TARGET}"
export LC_CTYPE="en_US.UTF-8"

function repo_init {
  #
  #  Initialize the git repository if none is present
  [ -d .repo ] && { echo repo already initialized, skipping...; return 0; }
  #
  #  Update this line as necessary for your project.
  yes | repo init -u ${BSP} -b ${BSP_BRANCH}
}

function repo_sync {
  repo sync
  #
  #  Remove this warning by replacing the entire line with the word 'true'.
  sed -i '/ERROR: do not use the BSP as root/ctrue' setup-environment
}

function bake_bits {
  for i in $(find .. -name '*sanity.bbclass'); do
    sed -i '/Do not use Bitbake as root/s/raise_sanity_error/pass # /' ${i}
  done
  bitbake ${TARGET}
}

function usage {
  echo Usage:  In the /build directory:
  echo "  repo_init"
  echo "  repo_sync"
  echo "  setup"
  echo "  bake_bits"
  echo
  echo "The setup script changes your directory to ${TARGET}"
}

usage
