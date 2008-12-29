# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#EGIT_BRANCH="next"
EGIT_REPO_URI="git://git.naquadah.org/awesome.git"
inherit cmake-utils git

DESCRIPTION="awesome is a floating and tiling window manager initialy based on a dwm code rewriting"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus doc"

COMMOM_DEPEND=">=dev-lang/lua-5.1
	dev-libs/libev
	>=dev-libs/glib-2
	dev-util/gperf
	media-libs/imlib2
	sys-libs/ncurses
	x11-libs/cairo[xcb]
	x11-libs/libX11[xcb]
	>=x11-libs/libxcb-1.1
	>=x11-libs/pango-1.19.3
	>=x11-libs/xcb-util-0.3
	dbus? ( >=sys-apps/dbus-1 )
	>=x11-proto/xproto-7.0.11"
DEPEND="${COMMOM_DEPEND}
	app-text/asciidoc
	app-text/xmlto
	>=dev-util/cmake-2.6
	dev-util/pkgconfig
	x11-proto/xcb-proto
	doc? (
		app-doc/doxygen
		dev-util/luadoc
		media-gfx/graphviz
	)"
# hmm, bash in system set?
RDEPEND="${COMMOM_DEPEND}
	x11-apps/xmessage
	media-gfx/feh"

DOCS="AUTHORS BUGS README STYLE"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with dbus DBUS)"

	if use doc ; then
		mycmakeargs="${mycmakeargs} -DGENERATE_LUADOC=ON"
	else
		mycmakeargs="${mycmakeargs} -DGENERATE_LUADOC=OFF"
	fi
	cmake-utils_src_configure
}

src_compile() {
	local myargs="all"
	use doc && myargs="${myargs} doc"
	cmake-utils_src_compile ${myargs}
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		einfo "Be patient! This might take a very long time."
		# paludis sucks!!!
		set -x && dohtml -r "${WORKDIR}"/${PN}_build/doc/html/* || die "dohtml failed"
		mv "${D}"/usr/share/doc/${PN}/luadoc "${D}"/usr/share/doc/${PF}/html/luadoc || die
	fi
	rm -rf "${D}"/usr/share/doc/${PN} || die "dodoc failed"

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN} || die "failed to install X session file"

	insinto /usr/share/xsessions
	doins ${PN}.desktop || die "failed to install desktop entry"
}
