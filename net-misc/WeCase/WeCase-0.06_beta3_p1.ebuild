# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} )
PYTHON_REQ_USE="threads,xml"
inherit eutils python-r1

DESCRIPTION="The Linux Sina Weibo Client"
HOMEPAGE="http://wecase.org/"

MY_PV="0.06-beta3.1"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${MY_PV}/${MY_P}.tar.bz2
	     https://github.com/WeCase/WeCase/raw/master/res/wecase.desktop"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
		app-arch/tar
        app-arch/bzip2"

RDEPEND="${PYTHON_DEPS}
		 dev-python/notify2
		 dev-python/PyQt4[dbus,X,${PYTHON_USEDEP}]"


S="${WORKDIR}/release"

src_unpack() {
	unpack ${MY_P}.tar.bz2
}

src_compile() {
	return
}

src_prepare() {
	cp "${DISTDIR}/wecase.desktop" ./
	echo "exec python3 /usr/libexec/wecase/wecase.py" > wecase
	rm notify2.py
}

src_install() {
	dodir /usr/libexec/wecase/
	cp -R . "${D}/usr/libexec/wecase" || die "Install failed!"

	exeinto /usr/bin/
	doexe wecase

	cp "ui/img/WeCase 854.png" "ui/img/WeCase.png"
	doicon "ui/img/WeCase.png"
	domenu "wecase.desktop"
}
