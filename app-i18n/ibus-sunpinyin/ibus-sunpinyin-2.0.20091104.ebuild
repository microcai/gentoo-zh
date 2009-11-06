# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit python

MY_PN="${PN##ibus-}"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://www.opensolaris.org/os/project/input-method"
SRC_URI="http://${PN}.googlecode.com/files/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

RDEPEND="x11-libs/gtk+
	>=dev-libs/glib-2
	>=app-i18n/ibus-1.2
	!app-i18n/scim-sunpinyin
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_PN}-2.0
RESTRICT="primaryuri"

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-ibus
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/ibus-sunpinyin/setup
}

pkg_postrm() {
	python_mod_cleanup /usr/share/ibus-sunpinyin/setup
}
