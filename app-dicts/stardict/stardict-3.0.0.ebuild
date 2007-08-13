# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-2.4.8.ebuild,v 1.4 2007/07/11 05:41:18 mr_bones_ Exp $

inherit gnome2 eutils autotools

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

IUSE="festival espeak gnome gucharmap spell"
DESCRIPTION="A GNOME2 international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://stardict.sourceforge.net/ http://cosoft.org.cn/projects/stardict/"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

RESTRICT="test"
LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="gnome? ( >=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/gconf-2
		>=gnome-base/orbit-2.6
		app-text/scrollkeeper )
	spell? ( app-text/enchant )
	gucharmap? ( >=gnome-extra/gucharmap-1.4.0 )
	festival? ( =app-accessibility/festival-1.96_beta
		=app-accessibility/speech-tools-1.2.96_beta )
	espeak? ( ~app-accessibility/espeak-1.26 )
	>=sys-libs/zlib-1.1.4
	>=x11-libs/gtk+-2.6"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-prefsdlg.cpp.diff
	epatch ${FILESDIR}/${P}-configure.in*.diff
	AT_M4DIR="m4" eautoreconf
	gnome2_omf_fix
}

src_compile() {
	export PKG_CONFIG=$(type -P pkg-config)
	G2CONF="$(use_enable gnome gnome-support) 
		$(use_enable spell)
		$(use_enable gucharmap)
		$(use_enable festival)
		$(use_enable espeak)"
	gnome2_src_compile
}

pkg_postinst() {
	elog "You will now need to install stardict dictionary files. If"
	elog "you have not, execute the below to get a list of dictionaries:"
	elog
	elog "  emerge -s stardict-"
	elog
	ewarn "If you upgraded from 2.4.1 or lower and use your own dictionary"
	ewarn "files, you'll need to run: /usr/share/stardict/tools/stardict_dict_update"
}
