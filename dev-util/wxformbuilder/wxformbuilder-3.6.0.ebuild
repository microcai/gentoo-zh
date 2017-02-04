# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WX_GTK_VER=2.8

inherit multilib wxwidgets

DESCRIPTION="The OpenSource wxWidgets Designer, GUI Builder, and RAD Tool."
HOMEPAGE="https://github.com/wxFormBuilder/wxFormBuilder"
SRC_URI="https://github.com/wxFormBuilder/wxFormBuilder/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/wxGTK:$WX_GTK_VER[debug=]"
DEPEND="${DEPEND}
	dev-util/premake"

S=${WORKDIR}/${PN}

src_prepare() {
	use debug || myconf="--disable-wx-debug"
	export CC=$(tc-getCC)
	export CXX=$(tc-getCXX)
	premake ${myconf} --target gnu --unicode --with-wx-shared \
			|| die "premake failediled"
}

src_compile() {
	use debug && myconf="Debug" || myconf="Release"
	emake CONFIG=${myconf} || die "make failed"
}

src_install() {
	dodoc output/{Changelog,license}.txt

	cd output

	use debug && mybin=wxformbuilderd || mybin=wxformbuilder
	dobin bin/${mybin}

	dodir /usr/$(get_libdir)/wxformbuilder
	mv lib/wxformbuilder "${D}"/usr/$(get_libdir)/

	newicon resources/icons/logo.png ${PN}.png
	make_desktop_entry ${mybin} WxFormBuilder ${PN}

	dodir /usr/share/wxformbuilder
	mv plugins resources xml "${D}"/usr/share/wxformbuilder/
}
