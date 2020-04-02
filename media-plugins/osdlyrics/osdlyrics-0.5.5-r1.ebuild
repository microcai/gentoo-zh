# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit python-r1 autotools

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://github.com/osdlyrics/osdlyrics"

MY_PVR="${PVR/r/rc}"
S="${WORKDIR}/${PN}-${MY_PVR}"
SRC_URI="https://github.com/osdlyrics/osdlyrics/archive/${MY_PVR}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome indicator"

RDEPEND="
	x11-libs/libnotify
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-util/intltool
	gnome? ( dev-libs/gobject-introspection )
	indicator? ( dev-libs/libappindicator )
"

DEPEND="
	${RDEPEND}
"

src_prepare() {
	default
	eautoreconf
	python_copy_sources
}

src_configure() {
	configuring() {
		local myconf=(
			--prefix="${EPREFIX}/usr" PYTHON="${PYTHON}"
		)
		econf "${myconf[@]}"
	}
	python_foreach_impl run_in_build_dir configuring
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	python_foreach_impl run_in_build_dir default
}
