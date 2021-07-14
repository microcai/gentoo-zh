# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils unpacker systemd

DESCRIPTION="A free peer-to-peer internet censorship circumvention tool"
HOMEPAGE="https://github.com/getlantern/lantern"
COMMIT="b9a807d5e5c2100b077394a7f4b833ad661c05c7"
SRC_URI="
	x86?   ( https://raw.githubusercontent.com/getlantern/lantern-binaries/${COMMIT}/lantern-installer-32-bit.deb -> lantern-bin-${PV}.x86.deb )
	amd64? ( https://raw.githubusercontent.com/getlantern/lantern-binaries/${COMMIT}/lantern-installer-64-bit.deb -> lantern-bin-${PV}.amd64.deb )"

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
	x11-libs/gdk-pixbuf:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PRESTRIPPED="/usr/lib/lantern/lantern-binary"

src_install() {
	insinto /
	doins -r "${S}/usr"

	fperms 0755 /usr/lib/lantern/lantern.sh

	use systemd && systemd_dounit "${FILESDIR}/lantern-bin.service"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
