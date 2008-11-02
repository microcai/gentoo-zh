# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="tint2 is a lightweight panel/taskbar"
HOMEPAGE="http://tint2.googlecode.com"
SRC_URI="http://tint2.googlecode.com/files/${P/2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+doc"

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# oooops
S=${WORKDIR}/${PN/2}/src

src_prepare() {
	# Portage can do this.
	sed -i \
		-e "/strip/d" Makefile \
		|| die "sed failed"
}

src_install() {
	exeinto /usr/bin
	newexe tint tint2

	cd ${WORKDIR}/${PN/2}
	dodoc ChangeLog README
	dodoc tintrc[1-4]
	use doc && dodoc doc/*
}

pkg_postinst() {
	echo
	if use doc ; then
		elog "For more info about how to use/config ${PN},"
	else
		elog "If you really  want to learn more about how to"
		elog "config/use ${PN}, rebuild this package with"
		elog "doc USE flag on. Then"
	fi
	elog "take a look at document in /usr/share/doc/${P}."
	echo
}
