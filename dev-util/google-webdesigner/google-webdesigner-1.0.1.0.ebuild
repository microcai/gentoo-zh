
# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Bring ideas to life across screens"
HOMEPAGE="https://www.google.com/webdesigner/index.html"

# Bundle a copy of libgcrypt, bug 494596
LIBGCRYPT="libgcrypt.so.11.8.2"


SRC_URI="amd64? ( https://dl.google.com/linux/direct/google-webdesigner_current_x86_64.rpm -> ${P}-x86_64.rpm
    http://dev.gentoo.org/~floppym/dist/${LIBGCRYPT}-amd64.xz
  )
  x86? (
  https://dl.google.com/linux/direct/google-webdesigner_current_i386.rpm -> ${P}-i386.rpm
  http://dev.gentoo.org/~floppym/dist/${LIBGCRYPT}-x86.xz
)
"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="
  x11-libs/gtk+:2
  dev-libs/libffi
  >=dev-libs/nspr-4.10
  >=dev-libs/nss-3.15
  sys-libs/zlib
  || (
    >=www-client/google-chrome-34
    www-client/google-chrome-unstable
    www-client/google-chrome-beta
    >=www-client/opera-12.16
  )
"

S="${WORKDIR}"

src_install(){
 rpm2tar -O ${DISTDIR}/${P}-*.rpm | tar -xvf - -C ${D}
 rm -rf ${D}/etc
 install -m 0755 ${LIBGCRYPT}-* ${D}/opt/google/webdesigner/libgcrypt.so.11
 ln -svf /usr/lib/libudev.so.1 ${D}/opt/google/webdesigner/libudev.so.0
}
