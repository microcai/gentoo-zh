#!/bin/sh

TMPDIR="/var/tmp/portage/sys-kernel/xanmod-hybrid-$1"
WORKDIR="${TMPDIR}/work"
DISTDIR="${TMPDIR}/distdir"
OKV="$1-xanmod"
XANMOD_VERSION="1"

mkdir ${WORKDIR}/patches
cp -vL ${DISTDIR}/patch-${OKV}${XANMOD_VERSION}.xz ${WORKDIR}/patches
cd ${WORKDIR}/patches
xz -d patch-${OKV}${XANMOD_VERSION}.xz	
cd ${WORKDIR}/linux-${OKV}
patch -p1 -f < ../patches/patch-$1-xanmod${XANMOD_VERSION} || true
