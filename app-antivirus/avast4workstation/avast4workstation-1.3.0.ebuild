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
RDEPEND=">=net-libs/libesmtp-1.0.3
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		>=dev-libs/glib-2.0.7
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/pango-1.0.5
		>=x11-libs/gtk+-2.0.9
		>=dev-libs/atk-1.0.3 )"

pkg_setup() {
		# This is a binary x86 package => ABI=x86
		# Please keep this in future versions
		# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
		has_multilib_profile && ABI="x86"
}

src_install() {
	oprefix="lib/${PN}"
	dobin bin/avast-update || die "dobin failed"
	doman share/man/man1/avast.1 || die "doman failed"
	dodoc share/doc/${P}/{FAQ,INSTALL,README,avast.pot} || die "dodoc failed"

	domenu ${oprefix}/share/avast/desktop/avast.desktop
	insinto /usr/share/pixmaps
	newins ${oprefix}/share/avast/icons/avast-appicon.png avastgui.png || die

	dodir /opt/${PN}/share
	mv ${oprefix}/{bin,lib,var} "${D}"/opt/${PN} || die
	mv ${oprefix}/share/avast "${D}"/opt/${PN}/share || die

	# XXX: set prefix.
	dodir /etc/env.d && echo "AVAST_PREFIX=/opt/avast4workstation" > "${D}"/etc/env.d/82avast

	dosym /opt/${PN}/lib/libavastengine-4.so.7.0.5 /usr/$(get_libdir)/libavastengine-4.so.7
	dosym /opt/${PN}/bin/wrapper-script.sh /usr/bin/avast
	dosym /opt/${PN}/bin/wrapper-script.sh /usr/bin/avastgui
}

pkg_postinst() {
	if use amd64 ; then
		ewarn "Please report back to oahong@gmail.com"
		ewarn "if you have a success story on this package. Thanks!"
	fi
	einfo "To update virus database automatically, add avasta-update"
	einfo "to your user crontab. See following link for more details:"
	einfo "http://www.gentoo.org/doc/en/cron-guide.xml"
}
