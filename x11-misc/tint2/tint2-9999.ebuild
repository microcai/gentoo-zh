# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.11-r1.ebuild,v 1.5 2012/09/11 17:38:41 idl0r Exp $

EAPI="3"

inherit cmake-utils eutils

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="http://tint2.googlecode.com/svn/trunk"
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
	inherit subversion
else
	MY_P="${PN}-${PV/_/-}"
	SRC_URI="http://tint2.googlecode.com/files/${MY_P}.tar.bz2"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"

LICENSE="GPL-2"
SLOT="0"
IUSE="examples tint2conf"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	media-libs/imlib2[X]"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto"
RDEPEND="${COMMON_DEPEND}
	tint2conf? ( x11-misc/tintwizard )"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		epatch "${FILESDIR}/gtk-icon-cache.sandbox.patch"
	else
		epatch "${FILESDIR}/battery_segfault.patch" # bug 343963
	fi
}

src_configure() {
	local mycmakeargs=( 
		-DBATTERY=ON
		$(cmake-utils_use_enable examples EXAMPLES)
		$(cmake-utils_use_enable tint2conf TINT2CONF)

		# bug 296890
		"-DDOCDIR=/usr/share/doc/${PF}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -f "${D}/usr/bin/tintwizard.py"
}
