# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A Tutorial and Presentation creation software, primarily aimed at creating tutorials on how to use software"
HOMEPAGE="http://www.debugmode.com/wink/"
SRC_URI="http://yet.another.linux-nerd.com/wink/download/wink15.tar.gz"
RESTRICT="strip fetch"

KEYWORDS="~x86"
SLOT="0"
LICENSE="FREEWARE"
IUSE=""

RDEPEND=""

S="${WORKDIR}"

pkg_nofetch()
{
	einfo " Hihi...download file here:"
	einfo ""
	einfo " $SRC_URI "
	einfo ""
	einfo ""
}

src_unpack() {
	tar -xzf "${DISTDIR}/wink15.tar.gz" 
	epatch "${FILESDIR}/installer.sh.patch"
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /opt/wink
	dodir /opt/bin

	./installer.sh ${D}/opt/wink

	exeinto /opt/bin
	newexe ${FILESDIR}/wink.sh wink

	dodir /etc/env.d
	echo -e "PATH=/opt/wink\n" > ${D}/etc/env.d/20wink
}
