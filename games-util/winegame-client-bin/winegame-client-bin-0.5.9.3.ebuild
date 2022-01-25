# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
PYTHON_REQ_USE="sqlite,threads(+)"

inherit unpacker xdg python-r1

DESCRIPTION="An open source gaming platform for GNU/Linux"
HOMEPAGE="https://winegame.net/"
SRC_URI="https://file.winegame.net/packages/debian/${PV}/net.winegame.client_${PV}_amd64.deb"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="app-arch/cabextract"

RDEPEND="
	app-arch/unzip
	app-arch/p7zip
	net-misc/curl
	net-misc/aria2
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/python-evdev[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/pydbus[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
	')
	gnome-base/gnome-desktop:3[introspection]
	gnome-extra/zenity
	media-sound/fluid-soundfont
	net-libs/webkit-gtk:4[introspection]
	x11-apps/mesa-progs
	x11-apps/xrandr
	x11-apps/xgamma
	x11-libs/gtk+:3[introspection]
	virtual/wine
"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r usr opt

	fperms -R 755 /opt/apps/net.winegame.client/files/bin
	fperms -R 755 /opt/apps/net.winegame.client/files/share/lutris/bin
}
