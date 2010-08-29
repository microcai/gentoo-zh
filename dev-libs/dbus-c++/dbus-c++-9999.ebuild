# Copyright 1999-2010 Mat
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EGIT_REPO_URI="git://gitorious.org/dbus-cplusplus/mainline.git"
inherit git autotools

DESCRIPTION="dbus-c++ attempts to provide a C++ API for D-BUS."
HOMEPAGE="http://www.freedesktop.org/wiki/Software/dbus-c++"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

# probably needs more/less crap listed here ...
RDEPEND="sys-apps/dbus
	"
DEPEND="${RDEPEND}
	dev-vcs/git
	dev-util/pkgconfig"

src_unpack() {
	git_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/fix_deadlock.patch"
	NOCONFIGURE=yes ./autogen.sh || die
}

src_compile() {
	econf --enable-debug || die
	emake -j1 || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TODO
}
