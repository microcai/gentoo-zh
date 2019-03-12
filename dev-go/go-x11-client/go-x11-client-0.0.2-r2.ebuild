# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Deepin GoLang X11 client Library"
HOMEPAGE="https://github.com/linuxdeepin/go-x11-client"
SRC_URI="https://github.com/linuxdeepin/go-x11-client/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		dev-lang/go
		>=dev-go/dde-go-essential-20170807"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	export GOPATH=${WORKDIR}

#	go get -d -f -u -v github.com/gavv/monotime || die
#	go get -d -f -u -v golang.org/x//text || die
	
	git clone https://github.com/golang/text.git
	rm -r ${S}/text/.git
	mkdir -p ${WORKDIR}/src/golang.org/x
	mv ${WORKDIR}/text ${WORKDIR}/src/golang.org/x/

	mkdir -p ${WORKDIR}/src/github.com/linuxdeepin/
	cp -r ${S}/${P}  ${WORKDIR}/src/github.com/linuxdeepin/${PN}

}

src_install() {
	insinto /usr/share/gocode
	doins -r ${WORKDIR}/src
}
