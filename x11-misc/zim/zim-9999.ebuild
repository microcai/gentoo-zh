# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2:2.5"

inherit distutils eutils fdo-mime virtualx bzr

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://zim-wiki.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz latex screenshot spell test"

RDEPEND="${DEPEND}
	graphviz? ( media-gfx/graphviz )
	latex? ( virtual/latex-base app-text/dvipng )
	screenshot? ( media-gfx/scrot )
	spell? ( dev-python/gtkspell-python )"
DEPEND="|| ( >=dev-lang/python-2.6 dev-python/simplejson )
	dev-python/pygtk
	x11-misc/xdg-utils"

EBZR_REPO_URI="lp:zim"

S=${WORKDIR}/${P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e "s/'USER'/'LOGNAME'/g" zim/__init__.py zim/fs.py || die
}

src_test() {
	export maketype="$(PYTHON)"
	virtualmake test.py || die
}

src_install () {
	doicon data/${PN}.png || die "doicon failed"
	distutils_src_install --skip-xdg-cmd
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	xdg-icon-resource install --context mimetypes --size 64 \
		"${ROOT}/usr/share/pixmaps/zim.png" \
		application-x-zim-notebook || die "xdg-icon-resource install failed"
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	xdg-icon-resource uninstall --context mimetypes --size 64 \
		application-x-zim-notebook || die "xdg-icon-resource uninstall failed"
}
