# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg shell-completion

MY_PV="${PV%.*}-${PV##*.}"
DESCRIPTION="Google Antigravity - AI-powered code editor"
HOMEPAGE="https://antigravity.google/"
SRC_URI="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/${MY_PV}/linux-x64/Antigravity.tar.gz -> ${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/Antigravity"

LICENSE="Google-TOS"

SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="egl kerberos wayland"
RESTRICT="bindist mirror strip"

RDEPEND="
	|| (
		sys-apps/systemd
		sys-apps/systemd-utils
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/libglvnd
	media-libs/mesa
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-process/lsof
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
	kerberos? ( app-crypt/mit-krb5 )
"

QA_PREBUILT="*"

src_prepare() {
	default
	pushd locales > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die
}

src_install() {
	# Disable update server
	sed -e "/updateUrl/d" -i resources/app/product.json || die

	if ! use kerberos; then
		rm -r resources/app/node_modules/kerberos || die
	fi

	dodir /opt/antigravity
	cp -ar . "${D}/opt/antigravity/" || die

	fperms 4711 /opt/antigravity/chrome-sandbox
	pax-mark m "${ED}/opt/antigravity/antigravity"
	dosym ../../opt/antigravity/antigravity /opt/bin/antigravity

	local EXEC_EXTRA_FLAGS=()
	if use wayland; then
		EXEC_EXTRA_FLAGS+=( "--ozone-platform-hint=auto" "--enable-wayland-ime" "--wayland-text-input-version=3" )
	fi
	if use egl; then
		EXEC_EXTRA_FLAGS+=( "--use-gl=egl" )
	fi

	# Desktop file
	make_desktop_entry \
		"antigravity ${EXEC_EXTRA_FLAGS[*]}" \
		"Antigravity" \
		"antigravity" \
		"Development;IDE;TextEditor" \
		"GenericName=Text Editor\nStartupNotify=true\nStartupWMClass=antigravity"

	# Install icon
	if [[ -f resources/app/resources/linux/code.png ]]; then
		local size
		for size in 16 24 32 48 64 128 256 512; do
			newicon -s "${size}" resources/app/resources/linux/code.png antigravity.png
		done
	fi

	# Shell completions
	if [[ -f resources/completions/bash/antigravity ]]; then
		newbashcomp resources/completions/bash/antigravity antigravity
	fi
	if [[ -f resources/completions/zsh/_antigravity ]]; then
		newzshcomp resources/completions/zsh/_antigravity _antigravity
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
}
