# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git-2 autotools

DESCRIPTION="dbus-c++ attempts to provide a C++ API for D-BUS."
HOMEPAGE="http://www.freedesktop.org/wiki/Software/dbus-c++"

EGIT_REPO_URI="git://gitorious.org/dbus-cplusplus/mainline.git"
EGIT_BOOTSTRAP="./autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# probably needs more/less crap listed here ...
RDEPEND="sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-vcs/git
	virtual/pkgconfig"

src_compile() {
	econf $(use_enable debug ) || die
	emake -j1 || die "emake failed"
}
