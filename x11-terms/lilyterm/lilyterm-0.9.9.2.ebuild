# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#MY_P=${PN}-$(replace_version_separator 3 '~')

DESCRIPTION="A light and easy to use libvte based X Terminal Emulator"
HOMEPAGE="http://lilyterm.luna.com.tw"
SRC_URI="${HOMEPAGE}/file/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls gtk3"
RDEPEND="gtk3? ( >=x11-libs/gtk+-3.0 )
	    !gtk3? ( >=x11-libs/gtk+-2.12:2 )
	gtk3? ( >=x11-libs/vte-0.32:2.90 )
	!gtk3? ( >=x11-libs/vte-0.12:0 )
	>=dev-libs/glib-2.14"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )
	nls? ( sys-devel/gettext )"

#S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

#src_prepare() {
#	sed -e '/examplesdir/s/\$(PACKAGE)/&-\${PV}/' \
#		-i data/Makefile.am || die "sed failed"
#
#}

with_gtk(){
	if use gtk3 ; then
		echo "--with-gtk=3.0"
	else
		echo "--with-gtk=2.0"
	fi	
}


src_configure(){
	econf $(with_gtk) $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
