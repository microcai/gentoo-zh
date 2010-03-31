# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Front-end for viewing of remote desktops in GNOME"
HOMEPAGE="https://launchpad.net/tsclient"
SRC_URI="
	mirror://ubuntu/pool/main/t/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://ubuntu/pool/main/t/${PN}/${PN}_${PV}-3ubuntu1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug vnc"

RDEPEND="
	>=dev-libs/atk-1.28.0
	>=dev-libs/glib-2.14.0
	>=gnome-base/gnome-panel-2.26.0
	>=gnome-base/libbonobo-2.15.0
	>=gnome-base/libbonoboui-2.15.1
	>=gnome-base/libgnomeui-2.22.0
	>=net-misc/rdesktop-1.3
	>=sys-libs/glibc-2.7
	>=x11-libs/gtk+-2.8.0
	vnc? (
		|| (
			net-misc/tigervnc
			net-misc/tightvnc ) )"
DEPEND="${RDEPEND}
	app-arch/sharutils
	>=dev-util/intltool-0.27
	dev-util/pkgconfig"

RESTRICT="mirror"

src_prepare() {
	cd "${WORKDIR}"
	epatch *.diff
	cd "${S}"
	EPATCH_SOURCE="${S}/debian/patches" EPATCH_SUFFIX="patch" \
		EPATCH_FORCE="yes" epatch
}

src_configure() {
	econf $(use_enable debug) || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	uudecode -o debian/harddrive.png{,.uue}
	cp debian/harddrive.png "${D}"/usr/share/pixmaps/${PN} || die "install failed"
	sed -i -r 's|^(Exec=tsclient)$|\1 -f|' "${D}"/usr/share/applications/${PN}.desktop || die
	dodoc debian/{changelog,copyright} AUTHORS NEWS README || die "install doc failed."
}

pkg_postinst() {
	if use vnc
	then
		ewarn "VNC support is still experimental.  Be sure to read"
		ewarn "/usr/share/doc/${PF}/README for more infomration."
		echo
	fi
}
