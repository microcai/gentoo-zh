# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 git-2

DESCRIPTION="Download scripts for xunlei vip users"
HOMEPAGE="https://github.com/iambus/xunlei-lixian"
EGIT_REPO_URI="https://github.com/iambus/xunlei-lixian.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}"

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
