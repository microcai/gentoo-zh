#!/bin/sh

TMPDIR="/var/tmp/portage/sys-kernel/xanmod-hybrid-$1"
WORKDIR="${TMPDIR}/work"
DISTDIR="${TMPDIR}/distdir"
OKV="$1-xanmod"
XANMOD_VERSION="1"

echo "Applying patch-${OKV}${XANMOD_VERSION}.patch"
mkdir ${WORKDIR}/patches
cp -L ${DISTDIR}/patch-${OKV}${XANMOD_VERSION}.xz ${WORKDIR}/patches
cd ${WORKDIR}/patches
xz -d patch-${OKV}${XANMOD_VERSION}.xz	
cd ${WORKDIR}/linux-${OKV}
patch -p1 -f < ../patches/patch-${OKV}${XANMOD_VERSION} >&/dev/null || true
