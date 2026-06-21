# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_PV="${PV/_p/-}"
MY_TAG="v${MY_PV}"
BASE_URI="https://github.com/vitaly-zdanevich/evernote-linux-repackage/releases/download/${MY_TAG}"

DESCRIPTION="Unofficial repackaging of the Evernote Electron desktop client, with black theme"
HOMEPAGE="https://github.com/vitaly-zdanevich/evernote-linux-repackage"
SRC_URI="
	amd64? (
		!stock? ( ${BASE_URI}/Evernote-${MY_TAG}-black-x86_64.AppImage -> ${P}-black-x86_64.AppImage )
		stock? ( ${BASE_URI}/Evernote-${MY_TAG}-x86_64.AppImage -> ${P}-stock-x86_64.AppImage )
	)
	arm64? (
		!stock? ( ${BASE_URI}/Evernote-${MY_TAG}-black-aarch64.AppImage -> ${P}-black-aarch64.AppImage )
		stock? ( ${BASE_URI}/Evernote-${MY_TAG}-aarch64.AppImage -> ${P}-stock-aarch64.AppImage )
	)
"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="appimage stock"

RESTRICT="bindist mirror strip"
QA_PREBUILT="*"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-lang/tk
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	virtual/libudev:=
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	x11-misc/wmctrl
	x11-misc/xdg-utils
"

appimage_name() {
	local theme
	if use stock; then
		theme="stock"
	else
		theme="black"
	fi

	case ${ARCH} in
		amd64)
			printf '%s-%s-x86_64.AppImage' "${P}" "${theme}"
			;;
		arm64)
			printf '%s-%s-aarch64.AppImage' "${P}" "${theme}"
			;;
		*)
			die "unsupported architecture: ${ARCH}"
			;;
	esac
}

src_unpack() {
	mkdir -p "${S}" || die

	local appimage
	appimage="$(appimage_name)"
	cp "${DISTDIR}/${appimage}" "${S}/${PN}.AppImage" || die
	chmod +x "${S}/${PN}.AppImage" || die

	cd "${S}" || die
	"${S}/${PN}.AppImage" --appimage-extract || die
}

src_prepare() {
	find "${S}" -type d -exec chmod a+rx {} + || die
	find "${S}" -type f -exec chmod a+r {} + || die
	chmod +x "${S}/${PN}.AppImage" || die

	default
}

src_install() {
	local apphome="/opt/${PN}"

	newicon -s 256 "${S}/squashfs-root/evernote.png" "${PN}.png"
	make_desktop_entry "${PN} %u" "Evernote" "${PN}" "Office;" \
		"StartupWMClass=Evernote\nMimeType=x-scheme-handler/evernote;x-scheme-handler/en;"

	if use appimage; then
		newbin "${S}/${PN}.AppImage" "${PN}"
	else
		dodir "${apphome}"
		cp -a "${S}/squashfs-root/." "${ED}/${apphome}/" || die
		make_wrapper "${PN}" "${apphome}/AppRun"
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "This is an unofficial Evernote Linux repackaging."
	elog "It is not affiliated with, endorsed by, or supported by Evernote or Bending Spoons."
	elog "The default install uses the black-themed release asset."
	elog "Enable USE=stock to install the non-themed upstream-style UI asset."
	elog "Enable USE=appimage to install the raw AppImage instead of extracting it into /opt."
}
