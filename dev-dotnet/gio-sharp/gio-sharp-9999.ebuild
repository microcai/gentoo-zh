# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git-2 mono

EGIT_BOOTSTRAP="autogen-2.22.sh"

DESCRIPTION="a branch of the official gtk#/gio to get gio# building on gtk# 2.12"
HOMEPAGE="http://gitorious.org/gio-sharp"
EGIT_REPO_URI="git://gitorious.org/${PN}/mainline.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-dotnet/glib-sharp
	dev-dotnet/gtk-sharp-gapi
	>=dev-lang/mono-2
	>=dev-libs/glib-2.22:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/autoconf
	sys-devel/automake"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
