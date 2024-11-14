# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

APPIMAGE="${P}_x86_64.AppImage"

inherit desktop pax-utils xdg optfeature

DESCRIPTION="Cursor App - AI-first coding environment"
HOMEPAGE="https://www.cursor.com/"
SRC_URI="https://download.todesktop.com/230313mzl4w4u92/${P}-build-24111460bf2loz1-x86_64.AppImage -> ${APPIMAGE}"
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

src_unpack() {
	cp "${DISTDIR}/${APPIMAGE}" "${S}" || die
	chmod +x "${S}/${APPIMAGE}" || die
	"${S}/${APPIMAGE}" --appimage-extract || die
}

src_install() {
	cd "${S}/squashfs-root" || die

	insinto /usr/share
	doins -r ./usr/share/icons

	local EXEC_EXTRA_FLAGS=()
	if use wayland; then
		EXEC_EXTRA_FLAGS+=( "--ozone-platform-hint=auto" "--enable-wayland-ime" )
	fi
	if use egl; then
		EXEC_EXTRA_FLAGS+=( "--use-gl=egl" )
	fi

	sed -e "s|^Exec=.*|Exec=cursor ${EXEC_EXTRA_FLAGS[*]} %U|" \
		cursor.desktop \
		> "${T}/cursor.desktop" || die

	rm -f -r \
		AppRun \
		cursor.desktop \
		cursor.png \
		.DirIcon \
		LICENSE.electron.txt \
		LICENSES.chromium.html \
		resources/app/ThirdPartyNotices.txt \
		usr || die

	insinto "/opt/${PN}"
	doins -r .

	fperms 4711 "/opt/${PN}/chrome-sandbox"
	fperms +x "/opt/${PN}/chrome_crashpad_handler"
	fperms +x "/opt/${PN}/cursor"
	pax-mark m "/opt/${PN}/cursor"

	dosym -r "/opt/${PN}/cursor" "/usr/bin/cursor"
	domenu "${T}/cursor.desktop"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
	optfeature "keyring support inside cursor" "virtual/secret-service"
}
