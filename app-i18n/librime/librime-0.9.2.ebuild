# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Rime Input Method Engine library"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="http://rimeime.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-i18n/opencc
	dev-cpp/yaml-cpp
	dev-db/kyotocabinet
	>=dev-libs/boost-1.46.0
	sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}
	dev-util/cmake"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -r 's| install-precompiled-data||' Makefile
}

src_install() {
	default_src_install

	einfo "Precompiling Rime schemas ..."
	LD_LIBRARY_PATH="${D}"/usr/lib/ "${D}"/usr/bin/rime_deployer \
		--build "${D}"/usr/share/rime-data \
		|| die "precompile failed"
}
