# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw
	ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop pax-utils unpacker xdg optfeature

DESCRIPTION="Cursor App - AI-first coding environment"
HOMEPAGE="https://www.cursor.com/"
SRC_URI="https://download.todesktop.com/230313mzl4w4u92/${P}-build-2412268nc6pfzgo-amd64.deb"
S="${WORKDIR}"

LICENSE="cursor"

SLOT="0"
KEYWORDS="-* amd64"
IUSE="egl kerberos wayland"
RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa
	net-misc/curl
	sys-apps/dbus
	sys-libs/zlib
	sys-process/lsof
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
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
	kerberos? ( app-crypt/mit-krb5 )
"

QA_PREBUILT="*"
CURSOR_HOME="opt/Cursor"

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd "${CURSOR_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die
}

src_install() {
	dodir /opt/cursor
	cp -ar "${CURSOR_HOME}/." "${D}/opt/cursor/" || die

	fperms 4711 /opt/cursor/chrome-sandbox
	pax-mark m /opt/cursor/cursor
	dosym ../cursor/cursor /opt/bin/cursor

	local EXEC_EXTRA_FLAGS=()
	if use wayland; then
		EXEC_EXTRA_FLAGS+=( "--ozone-platform-hint=auto" "--enable-wayland-ime" )
	fi
	if use egl; then
		EXEC_EXTRA_FLAGS+=( "--use-gl=egl" )
	fi

	sed -i -e "s|^Exec=.*|Exec=cursor ${EXEC_EXTRA_FLAGS[*]} %U|" \
		usr/share/applications/cursor.desktop || die
	domenu usr/share/applications/cursor.desktop

	insinto /usr/share
	doins -r usr/share/icons
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
	optfeature "keyring support inside cursor" "virtual/secret-service"
}
