# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WX_GTK_VER=2.8

inherit multilib wxwidgets

DESCRIPTION="The OpenSource wxWidgets Designer, GUI Builder, and RAD Tool."
HOMEPAGE="http://wxformbuilder.org"
#SRC_URI="mirror://sourceforge/${PN}/wxFormBuilder_v${PV}-src.tar.bz2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/wxGTK:2.8[debug=]
		dev-util/premake"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}_${PV}

src_prepare() {
	use debug || mydebug="--disable-wx-debug"
	export CC=$(tc-getCC)
	export CXX=$(tc-getCXX)
	premake \
		--verbose --target gnu --unicode ${mydebug} --with-wx-shared 2>/dev/null \
		|| die "premake failed"
}

src_compile() {
	use debug && myconfig="Debug" || myconfig="Release"
	emake CONFIG=${myconfig} || die "make failed"
}

src_install() {
	use debug && mybin=wxformbuilderd || mybin=wxformbuilder
	dobin "${S}"/output/bin/${mybin}
	rm -rf "${S}"/output/bin/

	dodir /usr/$(get_libdir)/wxformbuilder
	mv "${S}"/output/lib/wxformbuilder "${D}"/usr/$(get_libdir)/
	rm -rf "${S}"/output/lib/

	rm -rf "${S}"/output/share

	dodoc "${S}"/output/Changelog.txt
	rm -r "${S}"/output/*.txt

	dodir /usr/share/wxformbuilder
	cp -R "${S}"/output/* "${D}"/usr/share/wxformbuilder/

	newicon "${S}"/output/resources/icons/logo.png ${PN}.png
	make_desktop_entry ${mybin} "WxFormBuilder" ${PN} Development
}
