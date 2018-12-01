#
#  CentOS 7 is a very stable distribution, widely used in professional,
#  corporate and scientific organizations. A large, well-informed
#  community provides reliable, easy to find advice.
#
#  CentOS publishes their Docker image in a single layer, making it
#  an attractive choice from a performance view.
#
FROM centos:7
#
#  Each Docker command adds a layer.  Each layer decreases subsequent
#  build times but also decreases runtime performance.  Find a
#  balance between the two.  A good practice is to use several
#  layers during Dockerfile development, then squeeze out as many
#  as possible before producing the final Docker image.
#
#
#  Install the Yocto build prerequisites
#
#  Taken from https://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#centos-packages
RUN yum install -y epel-release \
  && yum makecache \
  && yum install -y \
    gawk \
    make \
    wget \
    tar \
    bzip2 \
    gzip \
    python \
    unzip \
    perl \
    patch \
    diffutils \
    difstat \
    git \
    cpp \
    gcc \
    gcc-c++ \
    glibc-devel \
    texingo \
    chrpath \
    socat \
    perl-Data-Dumper \
    perl-Text-ParseWords \
    perl-Thread-Queue \
    python34-pip xz \
    which \
    SDL-devel \
    xterm \
#  (We are intentionally not installing the graphical and documentation packages.
#  Add them if you like.)
#
#  Programs required by the board support package but not in the Yocto list
    diffstat \
    file \
    texinfo \
#
#  Install the 'repo' program into /usr/local/bin (so it is on the PATH)
#
  && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
  && chmod a+x /usr/local/bin/repo \
#
#  Preconfigure an identity for git.  This is only to keep 'repo' happy; it
#  has no other meaning.
  && git config --global user.email "w.e.coyote@acme.com" \
  && git config --global user.name "Wile E. Coyote" \
#
##############################################################################
#                                                                            #
#                     Project Specific Portion                               #
#                                                                            #
##############################################################################
#
#  This project employs the Boundary Devices Nitrogen6X board support package.
#  The Nitrogen6X uses a FreeScale processor.
#
#
#  Boundary Devices assumes the following directories exist.
  && mkdir --parents /opt/freescale/yocto/imx /opt/freescale/yocto/sstate-cache
#
#  Create a build directory in which to work.
WORKDIR /build


