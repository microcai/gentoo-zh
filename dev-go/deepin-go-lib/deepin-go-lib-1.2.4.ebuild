# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Deepin GoLang Library"
HOMEPAGE="https://github.com/linuxdeepin/go-lib"
SRC_URI="https://github.com/linuxdeepin/go-lib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		dev-lang/go
		>=dev-go/dde-go-essential-20171213"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
#	export GOPATH=${WORKDIR}

	mkdir -p ${WORKDIR}/src/pkg.deepin.io/ 
	cp -r ${S}/go-lib-${PV}  ${WORKDIR}/src/pkg.deepin.io/lib

}

src_install() {
	insinto /usr/share/gocode
	doins -r ${WORKDIR}/src
}
