# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit python-r1 distutils-r1 git-2

DESCRIPTION="Evernote SDK for Python"
HOMEPAGE="http://dev.evernote.com"

EGIT_REPO_URI="git://github.com/evernote/evernote-sdk-python.git"
EGIT_BRANCH="master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/thrift[python]
	dev-python/oauth2
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -rf lib/thrift
	python_convert_shebangs -r $(python_get_version) .
}

src_install() {
	distutils-r1_src_install
}
