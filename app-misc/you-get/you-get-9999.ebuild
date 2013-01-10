# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND=3

inherit python git-2

DESCRIPTION="A video downloader for youtube/youku"
HOMEPAGE="http://www.soimort.org/you-get"

EGIT_REPO_URI="git://github.com/soimort/you-get.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	python_set_active_version 3
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r $(python_get_version) .
}

src_install() {
	exeinto "$(python_get_sitedir)"/${PN}
	doexe ${PN} || die
	dosym $(python_get_sitedir)/${PN}/${PN} /usr/bin/${PN} || die

	insinto $(python_get_sitedir)/${PN}
	doins -r you_get/* || die
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
