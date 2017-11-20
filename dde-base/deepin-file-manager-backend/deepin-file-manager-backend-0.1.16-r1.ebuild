# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6


DESCRIPTION="Deepin file manager backend"
HOMEPAGE="https://github.com/linuxdeepin/deepin-file-manager-backend"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-wm/deepin-metacity
		 media-libs/libcanberra
		 app-text/poppler
	      "
DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
		  dev-go/go-gir-generator
	      dev-go/deepin-go-lib
	      dev-go/dbus-factory
	      >=dde-base/dde-api-2.92.2
	      "

src_prepare() {
	export GOPATH="/usr/share/gocode"
	default_src_prepare
}

#src_compile() {
#	emake USE_GCCGO=1
#}

src_install() {
	emake DESTDIR=${D} TARGET_DIR=${D}/usr/$(get_libdir)/deepin-daemon install
}
