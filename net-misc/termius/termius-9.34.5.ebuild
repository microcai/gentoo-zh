# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Desktop SSH Client"
HOMEPAGE="https://termius.com/download/linux"
SRC_URI="https://autoupdate.termius.com/linux/Termius.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="termius"
SLOT="0"
KEYWORDS="~amd64"
IUSE="egl wayland"
RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

src_install() {
	insinto /opt/termius
	doins -r opt/Termius/*

	exeinto /opt/termius
	doexe opt/Termius/termius-app
	doexe opt/Termius/chrome-sandbox

	fperms 4755 /opt/termius/chrome-sandbox

	dosym ../../opt/termius/termius-app /usr/bin/termius

	local EXEC_EXTRA_FLAGS=()
	if use wayland; then
		EXEC_EXTRA_FLAGS+=( "--ozone-platform-hint=auto" "--enable-wayland-ime" "--wayland-text-input-version=3" )
	fi
	if use egl; then
		EXEC_EXTRA_FLAGS+=( "--use-gl=egl" )
	fi

	sed -e "s|^Exec=.*|Exec=termius ${EXEC_EXTRA_FLAGS[*]} %U|" \
		usr/share/applications/termius-app.desktop > "${T}/termius-app.desktop" || die
	domenu "${T}/termius-app.desktop"

	for size in 16 24 32 48 64 128 256 512; do
		if [[ -f usr/share/icons/hicolor/${size}x${size}/apps/termius-app.png ]]; then
			doicon -s "${size}" usr/share/icons/hicolor/${size}x${size}/apps/termius-app.png
		fi
	done
}

pkg_postinst() {
	xdg_pkg_postinst
}
