# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND=2

inherit python git-2

DESCRIPTION="Download scripts for xunlei vip users"
HOMEPAGE="https://github.com/iambus/xunlei-lixian"

EGIT_REPO_URI="https://github.com/iambus/xunlei-lixian.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r $(python_get_version) .
}

src_install() {
	exeinto "$(python_get_sitedir)"/${PN}
	doexe *.py || die

	cp -r {lixian_commands,lixian_plugins} "${D}/$(python_get_sitedir)/${PN}"

	dosym "$(python_get_sitedir)"/${PN}/lixian_cli.py /usr/bin/${PN}-cli || die
	dosym "$(python_get_sitedir)"/${PN}/lixian_hash.py /usr/bin/${PN}-hash || die
	dosym "$(python_get_sitedir)"/${PN}/lixian_batch.py /usr/bin/${PN}-batch || die
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
