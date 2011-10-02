# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A chinese p2p streaming video player."
HOMEPAGE="http://www.ppstream.com"
SRC_URI="http://download.ppstream.com/linux/PPStream.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x86? ( >=x11-libs/qt-core-4.4.0
               >=x11-libs/qt-gui-4.4.0
		       >=x11-libs/qt-webkit-4.4.0 )
		amd64? ( app-emulation/emul-linux-x86-qtlibs )
		media-video/mplayer"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	einfo "Unpacking application binary ..."
	tar xvf ${WORKDIR}/data.tar.gz || die "Unpack application binary failed."
}

src_install() {
	insinto /opt/pps/share
	doins opt/pps/share/default_background.gif || die "doins failed."

	exeinto /opt/pps/bin
	doexe opt/pps/bin/* || die "doexe failed."

	exeinto /opt/pps/lib
	doexe opt/pps/lib/* || die "doins failed."

	insinto /usr/share/applications
	doins usr/share/applications/pps.desktop || die "doins failed."

	insinto /usr/share/icons/pps
	doins usr/share/icons/pps/pps_logo.png || die "doins failed."

	insinto /etc
	doins etc/ems.conf || die "doins failed."

	dosym /opt/pps/bin/PPStream /usr/bin/PPStream || die
	dosym /opt/pps/lib/libemscore.so.0.1.* /usr/bin/libemscore.so || die
	dosym /opt/pps/lib/libemsnet.so.0.1.* /usr/bin/libemsnet.so || die
	dosym /opt/pps/lib/libemscore.so.0.1.* /usr/lib/libemscore.so.0 || die
	dosym /opt/pps/lib/libemsnet.so.0.1.* /usr/lib/libemsnet.so.0 || die
}
