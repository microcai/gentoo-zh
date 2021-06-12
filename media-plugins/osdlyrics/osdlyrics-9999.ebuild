# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8,9} )

inherit python-r1 autotools git-r3

DESCRIPTION="Standalone lyrics fetcher/displayer (windowed and OSD mode)."
HOMEPAGE="https://github.com/osdlyrics/osdlyrics"

EGIT_REPO_URI="https://github.com/osdlyrics/osdlyrics.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

if [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT="818bac81ea3454bd9754602888203e0786cfd50b"
else
	KEYWORDS=""
fi

IUSE="gnome indicator"

RDEPEND="
	x11-libs/libnotify
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	gnome? ( dev-libs/gobject-introspection )
	indicator? ( dev-libs/libappindicator )
"

DEPEND="
	dev-util/intltool
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
