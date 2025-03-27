# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar az bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr
	gu he hi hr hu id it ja ka km kn ko lt lv mk ml mn mr ms my nb nl pl pt-BR pt-PT ro ru si sk
	sl sq sr-Latn sr sv sw ta te th tr uk ur uz vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg

MY_PN=${PN/-bin}-browser
DESCRIPTION="Web browser that blocks ads and trackers by default"
HOMEPAGE="https://brave.com/"
SRC_URI="https://github.com/${PN/-bin}/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"

S=${WORKDIR}

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* amd64"

IUSE="qt5 qt6"
RESTRICT="bindist strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/pango
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[X]
		dev-qt/qtwidgets:5
	)
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
"

QA_PREBUILT="*"
BRAVE_HOME="opt/brave.com/brave"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	# The appdata directory is deprecated.
	mv usr/share/{appdata,metainfo}/ || die

	# Remove cron job and menu for updating from Debian repos.
	rm -r ${BRAVE_HOME}/cron/ || die
	rm -r etc usr/share/menu || die

	# Rename docs directory to our needs.
	mv usr/share/doc/${MY_PN} usr/share/doc/${PF} || die

	# Decompress the docs.
	gzip -d usr/share/doc/${PF}/changelog.gz || die
	gzip -d usr/share/man/man1/${MY_PN}-stable.1.gz || die
	if [[ -L usr/share/man/man1/brave-browser.1.gz ]]; then
	    rm usr/share/man/man1/brave-browser.1.gz || die
	    dosym ${MY_PN}-stable.1 usr/share/man/man1/brave-browser.1
	fi

	# Remove unused language packs
	pushd "${BRAVE_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	if ! use qt5; then
		rm "${BRAVE_HOME}/libqt5_shim.so" || die
	fi
	if ! use qt6; then
		rm "${BRAVE_HOME}/libqt6_shim.so" || die
	fi

	local logo size
	for logo in "${ED}"/${BRAVE_HOME}/product_logo_*.png; do
	    size=${logo##*_}
		size=${size%.*}
		newicon -s "${size}" "${logo}" ${PN/-bin}.png
	done

	pax-mark m "${BRAVE_HOME}/brave"
	fperms 4711 "/${BRAVE_HOME}/chrome-sandbox"
}
