# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6


DESCRIPTION="starter of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/startdde"
if [[ "${PV}" == *9999* ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dde-base/dde-daemon-3.1.17
 		dde-base/deepin-wm-switcher
		>=dde-base/deepin-desktop-schemas-3.1.15
		"

DEPEND="${RDEPEND}
	      dev-lang/coffee-script
	      dev-go/go-dbus-generator
	      dev-util/cmake
		  >=dde-base/dde-api-3.1.8
	      >=dev-go/deepin-go-lib-1.1.0
	      >=dev-go/dbus-factory-3.1.5"

src_prepare() {
# 	  sed -i 's|${GOPATH}:${CURDIR}/${GOBUILD_DIR}|${CURDIR}/${GOBUILD_DIR}:${GOPATH}|g' Makefile
	  export GOPATH="/usr/share/gocode"
	  LIBDIR=$(get_libdir)
	  sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" Makefile
	  default_src_prepare
}

#src_compile() {
#	emake USE_GCCGO=1
#}

src_install() {
	  emake DESTDIR="${D}" install
	  mv ${D}/lib/systemd ${D}/usr/$(get_libdir)/systemd
	  rm -r ${D}/lib
	  dosym ../dde-readahead.service /usr/$(get_libdir)/systemd/system/multi-user.target.wants/dde-readahead.service

}
