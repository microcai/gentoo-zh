# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit qt5-build

DESCRIPTION="A lightweight and ultra-fast shadowsocks library written in C++/Qt"
HOMEPAGE="https://github.com/shadowsocks/libQtShadowsocks"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/libQtShadowsocks/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"

IUSE="libqss"

DEPEND=">dev-libs/botan-1.10[threads]
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtnetwork
	dev-qt/qttest:5
	sys-devel/gcc[cxx]"

QT5_TARGET_SUBDIRS=(
	lib
)

src_unpack() {
	tar --no-same-owner -xof ${DISTDIR}/${P}.tar.gz -C ${WORKDIR} || die "tar error"
	mv ${WORKDIR}/${P} ${WORKDIR}/${PN}-opensource-src-${PV} || die
}

pkg_setup() {
	use libqss && QT5_TARGET_SUBDIRS+=(shadowsocks-libqss)
}

src_configure() {
	local myconf=(
		$(use libqss)
	)
	qt5-build_src_configure
}
