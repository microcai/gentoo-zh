# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg

MY_PN="thorium-browser"

DESCRIPTION="Chromium fork focused on high performance and security"
HOMEPAGE="https://thorium.rocks"
DIST_URI="https://github.com/Alex313031/thorium/releases/download/M${PV}/thorium-browser_${PV}"
SRC_URI="
	cpu_flags_x86_avx2? ( ${DIST_URI}_AVX2.deb )
	!cpu_flags_x86_avx2? (
		cpu_flags_x86_avx? ( ${DIST_URI}_AVX.deb )
		!cpu_flags_x86_avx? (
			cpu_flags_x86_sse4_1? ( ${DIST_URI}_SSE4.deb )
			!cpu_flags_x86_sse4_1? ( cpu_flags_x86_sse3? ( ${DIST_URI}_SSE3.deb ) )
		)
	)
"

S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* amd64"
IUSE="cpu_flags_x86_aes cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_sse3 cpu_flags_x86_sse4_1 qt5 qt6"

REQUIRED_USE="
	cpu_flags_x86_aes
	|| ( cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_sse3 cpu_flags_x86_sse4_1 )
"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-fonts/liberation-fonts
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	|| (
		x11-libs/gtk+:3[X]
		gui-libs/gtk:4[X]
	)
	x11-libs/libdrm
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-misc/xdg-utils
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[X]
		dev-qt/qtwidgets:5
	)
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
	!www-client/thorium-browser
"

QA_PREBUILT="*"
QA_DESKTOP_FILE='usr/share/applications/thorium.*\.desktop'
THORIUM_HOME="opt/chromium.org/thorium"

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

	rm usr/bin/pak || die

	rm -r etc usr/share/menu || die
	mv "usr/share/doc/${MY_PN}" "usr/share/doc/${PF}" || die

	gzip -d "usr/share/doc/${PF}/changelog.gz" || die
	gzip -d "usr/share/man/man1/${MY_PN}.1.gz" || die

	pushd "${THORIUM_HOME}/locales" >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die

	if ! use qt5; then
		rm "${THORIUM_HOME}/libqt5_shim.so" || die
	fi
	if ! use qt6; then
		rm "${THORIUM_HOME}/libqt6_shim.so" || die
	fi

	local size
	for size in 16 24 32 48 64 128 256; do
		newicon -s ${size} "${THORIUM_HOME}/product_logo_${size}.png" "${MY_PN}.png"
	done
	doicon -s 256 "${THORIUM_HOME}/thorium_shell.png"

	pax-mark m "${THORIUM_HOME}/thorium{,_shell}"
}
