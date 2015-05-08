# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

DESCRIPTION="avast! Linux Home Edition"
HOMEPAGE="http://www.avast.com/eng/avast-for-linux-workstation.html"
SRC_URI="http://files.avast.com/files/linux/${P}.tar.gz"

LICENSE="ALWIL-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
		>=dev-libs/glib-2.0.7[abi_x86_32]
		x11-libs/libX11[abi_x86_32]
		x11-libs/libXext[abi_x86_32]
		>=x11-libs/pango-1.0.5[abi_x86_32]
		>=x11-libs/gtk+-2.0.9:2[abi_x86_32]
		>=dev-libs/atk-1.0.3[abi_x86_32]"
DEPEND=""

RESTRICT="mirror"

QA_PRESTRIPPED="
	opt/${PN}/bin/avast
	opt/${PN}/bin/avastgui
	opt/${PN}/lib/libesmtp.so.5.1.4
	opt/${PN}/lib/libavastengine-4.so.7.0.5"
QA_TEXTRELS="opt/${PN}/lib/libavastengine-4.so.7.0.5"

pkg_setup() { has_multilib_profile && ABI="x86"; }

src_install() {
	DESTDIR=${D}/opt/${PN}
	LIBDIR=${S}/lib/${PN}

	exeinto /opt/${PN}/bin
	doexe bin/avast-update "${LIBDIR}"/bin/{avast{,gui},wrapper-script.sh} || die "doexe failed"
	dosym /opt/${PN}/bin/wrapper-script.sh /opt/bin/avast
	dosym /opt/${PN}/bin/wrapper-script.sh /opt/bin/avastgui
	dosym /opt/${PN}/bin/avast-update /opt/bin/avast-update

	sed -i -e "s|^Categories=.*|Categories=Application;Security;System;|" \
		"${LIBDIR}"/share/avast/desktop/avast.desktop || die
	domenu "${LIBDIR}"/share/avast/desktop/avast.desktop || die "domenu failed"
	rm -r "${LIBDIR}"/share/avast/desktop
	dodir /usr/share/pixmaps
	dosym /opt/${PN}/share/avast/icons/avast-appicon.png /usr/share/pixmaps/avastgui.png

	mv share "${LIBDIR}"/{lib,var} "${DESTDIR}" || die "install failed"
	mv "${LIBDIR}"/share/avast "${DESTDIR}"/share || die "install failed"
	mv "${LIBDIR}"/lib-esmtp/* "${DESTDIR}"/lib || die "install failed"

	cat > 82avast << DONE
AVAST_PREFIX="/opt/${PN}"
MANPATH="/opt/${PN}/share/man"
DONE
	doenvd 82avast
}

pkg_postinst() {
	ewarn "After the update on 3/29/2010, AVAST isn't able to initialise."
	ewarn "See following link for more details and solution:"
	ewarn "http://forum.avast.com/index.php?topic=57812.0"
}
