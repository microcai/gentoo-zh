# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils versionator

MY_P="${PN}-$(get_version_component_range 1-2)"
MY_P="${MY_P}-u$(get_version_component_range 3)"
MY_P="${MY_P}-b$(get_version_component_range 4)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="unix port of Monkey's Audio"
HOMEPAGE="http://sourceforge.net/projects/mac-port"
#SRC_URI="mirror://sourceforge/mac-port/${MY_P}.tar.gz"
SRC_URI="http://www.genoetigt.de/ape/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="backward-compatible"

DEPEND="virtual/libc
	x86? ( dev-lang/nasm )"

src_compile() {
# not necessary anymore since 3.99.4.5 ? all 'int' are now 'intptr_t'
#	epatch ${FILESDIR}/mac-precision.patch || die
#	epatch ${FILESDIR}/mac-pointercasting.patch || die

	econf `use_enable backward-compatible backward` || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS INSTALL NEWS README TODO COPYING 
	dohtml ${S}/src/License.htm	${S}/src/Readme.htm
}
