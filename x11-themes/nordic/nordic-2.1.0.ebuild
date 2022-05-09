# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dark Gtk3.20+ theme created using the awesome Nord color pallete"
HOMEPAGE="https://github.com/EliverLara/Nordic"
SRC_URI="https://github.com/EliverLara/Nordic/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk2 +gtk3 xfce mate gnome-shell cinnamon"

S="${WORKDIR}/Nordic-${PV}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/themes/Nordic-v40
	doins -r ./{index.theme,gtk-2.0,gtk-3.0,kde}
	use xfce && doins ./xfwm4
	use mate && doins ./metacity-1
	use gnome-shell && doins ./gnome-shell
	use cinnamon && doins ./cinnamon
}
