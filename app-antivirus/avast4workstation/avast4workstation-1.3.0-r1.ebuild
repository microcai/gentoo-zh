# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

DESCRIPTION="avast! Linux Home Edition"
HOMEPAGE="http://www.avast.com/eng/avast-for-linux-workstation.html"
SRC_URI="http://files.avast.com/files/linux/${P}.tar.gz"

LICENSE="ALWIL-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		>=net-libs/libesmtp-1.0.3
		>=dev-libs/glib-2.0.7
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/pango-1.0.5
		>=x11-libs/gtk+-2.0.9
		>=dev-libs/atk-1.0.3 )"

RESTRICT="strip"
QA_TEXTRELS="opt/${PN}/lib/libavastengine-4.so.7.0.5"

pkg_setup() {
		# This is a binary x86 package => ABI=x86
		# Please keep this in future versions
		# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
		has_multilib_profile && ABI="x86"
}

src_install() {
	dodir /opt/${PN}/share
	mv share "${D}"/opt/${PN} || die "mv failed 1"

	exeinto /opt/${PN}/bin
	doexe bin/avast-update || die "doexec failed"

	cd lib/${PN}
	domenu share/avast/desktop/avast.desktop
	insinto /usr/share/pixmaps
	newins share/avast/icons/avast-appicon.png avastgui.png || die "newins failed"

	mv share/avast "${D}"/opt/${PN}/share || die "mv failed 2"
	mv lib var "${D}"/opt/${PN} || die "mv failed 3"
	if use amd64 ; then
		mv lib-esmtp/* "${D}"/opt/${PN}/lib || die "failed to install libesmtp"
	fi

	exeinto /opt/${PN}/bin
	doexe bin/avast{,gui} bin/wrapper-script.sh || die "doexec failed"

	cat > 82avast << DONE
AVAST_PREFIX="/opt/${PN}"
MANPATH="/opt/${PN}/share/man"
DONE
	doenvd 82avast

	dosym /opt/${PN}/bin/wrapper-script.sh /opt/bin/avast
	dosym /opt/${PN}/bin/wrapper-script.sh /opt/bin/avastgui
	dosym /opt/${PN}/bin/avast-update /opt/bin/avast-update
}

pkg_postinst() {
	einfo "To update virus database automatically, add avast-update"
	einfo "to your user crontab. See following link for more details:"
	einfo "http://www.gentoo.org/doc/en/cron-guide.xml"
}
