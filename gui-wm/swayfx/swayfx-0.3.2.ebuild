# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature

DESCRIPTION="SwayFX: Sway, but with eye candy!"
HOMEPAGE="https://github.com/WillPower3309/swayfx"
SRC_URI="https://github.com/WillPower3309/swayfx/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="grimshot +man +swaybar +swaynag tray wallpapers X"

DEPEND="
	>=dev-libs/json-c-0.13:0=
	>=dev-libs/libinput-1.21.0:0=
	sys-auth/seatd:=
	dev-libs/libpcre
	>=dev-libs/wayland-1.20.0
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	media-libs/mesa[gles2,libglvnd(+)]
	swaybar? ( x11-libs/gdk-pixbuf:2 )
	tray? ( || (
		sys-apps/systemd
		sys-auth/elogind
		sys-libs/basu
	) )
	wallpapers? ( gui-apps/swaybg[gdk-pixbuf(+)] )
	X? ( x11-libs/libxcb:0= )
"
DEPEND+="
	>=gui-libs/wlroots-0.16:=[X?]
	<gui-libs/wlroots-0.17:=[X?]
"
RDEPEND="
	x11-misc/xkeyboard-config
	grimshot? (
		app-misc/jq
		gui-apps/grim
		gui-apps/slurp
		gui-apps/wl-clipboard
		x11-libs/libnotify
	)
	!!gui-wm/sway
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	>=dev-build/meson-0.60.0
	virtual/pkgconfig
"
BDEPEND+="man? ( >=app-text/scdoc-1.9.3 )"
REQUIRED_USE="tray? ( swaybar )"

src_prepare() {
	eapply "${FILESDIR}/${P}-im.patch"
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature tray)
		$(meson_feature X xwayland)
		$(meson_feature swaybar gdk-pixbuf)
		$(meson_use swaynag)
		$(meson_use swaybar)
		$(meson_use wallpapers default-wallpaper)
		-Dfish-completions=true
		-Dzsh-completions=true
		-Dbash-completions=true
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use grimshot; then
		doman contrib/grimshot.1
		dobin contrib/grimshot
	fi
}

pkg_postinst() {
	optfeature_header "There are several packages that may be useful with swayfx:"
	optfeature "wallpaper utility" gui-apps/swaybg
	optfeature "idle management utility" gui-apps/swayidle
	optfeature "simple screen locker" gui-apps/swaylock
	optfeature "lightweight notification daemon" gui-apps/mako
	echo
	einfo "For a list of additional addons and tools usable with sway please"
	einfo "visit the offical wiki at:"
	einfo "https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway"
	einfo "Please note that some of them might not (yet) available on gentoo"
}
