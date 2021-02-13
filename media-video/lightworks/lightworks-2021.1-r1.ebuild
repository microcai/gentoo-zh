# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION="Lightworks is the fastest, most accessible and focused NLE in the industry"
HOMEPAGE="http://www.lwks.com/"
SRC_URI="https://github.com/HougeLangley/lwks-beta/releases/download/lwks-reversion/lightworks_2021.1_r126716.deb"

LICENSE="EditShare"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT=""
IUSE=""

RDEPEND="
	dev-libs/openssl
	dev-libs/glib
	dev-libs/atk
	dev-libs/expat
	dev-libs/libffi
	sys-apps/dbus
	virtual/udev
	x11-libs/pango
	x11-libs/gdk-pixbuf
	x11-libs/cairo
	x11-libs/pixman
	x11-libs/gtk+
	media-libs/libjpeg-turbo
	gnome-extra/libgsf
	media-libs/libpng
	virtual/jpeg
	media-libs/tiff
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/glu
	media-libs/mesa
	media-libs/portaudio[jack] 
	>=media-gfx/nvidia-cg-toolkit-3.1.0013-r2
	x11-libs/libxcb
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrender
	x11-libs/libXfixes
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libdrm
	app-accessibility/at-spi2-core
"

DEPEND="${RDEPEND}
	!app-arch/deb2targz
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.xz
}

src_prepare() {
    eapply_user
    sed -i -e "s|^GDK.*|GDK_BACKEND=x11 /usr/lib64/lightworks/ntcardvt|" usr/bin/lightworks || die
}


src_install() {
	exeinto /usr/bin
	doexe usr/bin/lightworks
	domenu usr/share/applications/lightworks.desktop
	doicon usr/share/lightworks/Icons/App.png
	
	insinto /usr/lib64/${PN}
	doins -r usr/lib/${PN}/* || die "doins lib failed"

	exeinto /usr/lib64/${PN}
	doexe usr/lib/${PN}/ntcardvt || die "doins lib-exe failed"

	fperms a+rw "usr/share/lightworks/Preferences"
	fperms a+rw "usr/share/lightworks/Audio Mixes"

	insinto /usr/share/${PN}
	doins -r usr/share/${PN}/* || die "doins share failed"

	insinto /usr/share/fonts
	doins -r usr/share/fonts/* || die "doins fonts failed"
	mkfontdir "${D}/usr/share/fonts/truetype"

	dodoc usr/share/doc/${PN}/*
}


