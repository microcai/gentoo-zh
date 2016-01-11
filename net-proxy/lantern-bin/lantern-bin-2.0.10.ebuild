# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit gnome2-utils unpacker systemd

DESCRIPTION="A free desktop application that delivers fast, reliable and secure access to the open Internet for users in censored regions."
HOMEPAGE="https://github.com/getlantern/lantern"
SRC_URI="
	x86?   ( https://raw.githubusercontent.com/getlantern/lantern-binaries/3abfcff58b6d03071ce1d841ae64c25b3eab9344/lantern-installer-32-bit.deb )
	amd64? ( https://raw.githubusercontent.com/getlantern/lantern-binaries/3abfcff58b6d03071ce1d841ae64c25b3eab9344/lantern-installer-64-bit.deb )"

SLOT="0"
RESTRICT="mirror"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="
	app-arch/bzip2
	app-arch/lz4
	dev-libs/glib:2[xattr]
	dev-libs/libappindicator:3
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz[graphite]
	media-libs/libepoxy
	media-libs/mesa
	sys-apps/dbus
	systemd? ( sys-apps/systemd )
	sys-libs/glibc:2.2
	sys-libs/libcap
	sys-libs/zlib
	x11-base/xorg-server
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2[X]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	# lantern will update itself
	rm ${S}/usr/lib/lantern/lantern.sh || die
}

src_install() {
	# remove /usr/bin/lantern
	rm ${S}/usr/bin/lantern

	insinto /
	doins -r "${S}/usr"
	fperms 0755 /usr/lib/lantern/lantern-binary

	insinto /usr/share/applications
	doins "${FILESDIR}/lantern-bin.desktop"

	use systemd && systemd_dounit "${FILESDIR}/lantern-bin.service"
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
