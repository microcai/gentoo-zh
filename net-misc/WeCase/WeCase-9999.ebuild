# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )
PYTHON_REQ_USE="threads,xml"
inherit eutils python-r1 git-2 autotools

DESCRIPTION="A Sina Weibo Client Focusing on Linux."
HOMEPAGE="http://wecase.org/"

RESTRICT="mirror"
SRC_URI=""

EGIT_HAS_SUBMODULES=1
EGIT_REPO_URI="https://github.com/WeCase/WeCase.git"
EGIT_BRANCH="dev-0.06"

LICENSE="GPL-3+ LGPL-2.1 LGPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${PYTHON_DEPS}
		app-arch/tar
        app-arch/bzip2
		dev-python/PyQt4
		dev-qt/qtcore"

RDEPEND="${PYTHON_DEPS}
		 dev-python/notify2
		 dev-python/rpweibo
		 dev-python/PyQt4[dbus,X,${PYTHON_USEDEP}]"


src_prepare() {
	eautoreconf
}

src_configure() {
	econf --with-pkgprovider="Gentoo Foundation"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	cd "${S}"/sdk
}
