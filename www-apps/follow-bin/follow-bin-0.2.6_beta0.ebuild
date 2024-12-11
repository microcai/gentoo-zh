# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

MY_PV=$(ver_cut 1-3)-$(ver_cut 4).$(ver_cut 5)

DESCRIPTION="Next generation information browser"
HOMEPAGE="
	https://follow.is/
	https://github.com/RSSNext/Follow
"
SRC_URI="
	https://github.com/RSSNext/Follow/releases/download/v${MY_PV}/Follow-${MY_PV}-linux-x64.AppImage -> ${P}.AppImage
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/at-spi2-core
	app-arch/bzip2
	app-arch/zstd
	app-crypt/p11-kit
	dev-libs/elfutils
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/gmp
	dev-libs/icu
	dev-libs/libffi
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/libxml2
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	media-libs/libjpeg-turbo
	media-libs/mesa
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-apps/systemd
	sys-apps/util-linux
	sys-devel/gcc
	llvm-core/llvm:18
	sys-libs/glibc
	sys-libs/libcap
	sys-libs/ncurses
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxshmfence
"

src_unpack() {
	mkdir -p "${S}" || die
	cp "${DISTDIR}/${P}.AppImage" "${S}" || die

	cd "${S}" || die         # "appimage-extract" unpacks to current directory.
	chmod +x "${S}/${P}.AppImage" || die
	"${S}/${P}.AppImage" --appimage-extract || die
}

src_install() {
	cd "${S}/squashfs-root" || die

	domenu Follow.desktop

	local toremove=(
		.DirIcon
		Follow.desktop
		Follow.png
		AppRun
		LICENSES.chromium.html
		usr
	)
	rm -f -r "${toremove[@]}" || die

	local apphome="/opt/${PN}"
	insinto "${apphome}"
	doins -r .

	fperms +x "${apphome}/Follow"
	dosym -r "${apphome}/Follow" "/opt/bin/Follow"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
