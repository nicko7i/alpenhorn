#!/bin/bash

function repo_init {
  #
  #  Initialize the git repository if none is present
  [ -d .repo ] && { echo repo already initialized, skipping...; return 0; }
  #
  #  Update this line as necessary for your project.
  yes | repo init -u http://github.com/boundarydevices/boundary-bsp-platform -b pyro
}

function repo_sync {
  repo sync
  #
  #  At the time this is written, there is a mistake in a configuration file.
  sed -i '/CONNECTIVITY_CHECK_URIS/cCONNECTIVITY_CHECK_URIS=""' conf/local.conf
}

function setup_environment {
  #
  #  Update this line as necessary for your project.
  MACHINE=nitrogen6x DISTRO=fslc-framebuffer \
  source setup-environment core-image-minimal
}

function bake_bits {
  bitbake core-image-minimal
}

function do_it_all {
  repo_init
  repo_sync
  setup_environment
  fixup_environment
  bake_bits
}
alias setup='MACHINE=nitrogen6x DISTRO=fslc-framebuffer \
  source setup-environment core-image-minimal'
