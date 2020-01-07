# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit gnome2 eutils autotools

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

IUSE="festival espeak gnome gucharmap spell gpe qqwry"
DESCRIPTION="A GNOME2 international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://code.google.com/p/stardict-3/"
SRC_URI="http://stardict-3.googlecode.com/files/${P}.tar.bz2"

RESTRICT="test mirror"
LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="~sparc ~x86 ~amd64"

DEP="gnome? ( >=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/libgnomeui-2.20
		>=gnome-base/gconf-2.6
		>=gnome-base/orbit-2.6
		app-text/scrollkeeper
		app-text/gnome-doc-utils )
	spell? ( app-text/enchant )
	gucharmap? ( >=gnome-extra/gucharmap-2.22.1 )
	gpe? (
		>=gpe-base/libgpewidget-0.109
	)
	>=sys-libs/zlib-1.1.4
	>=x11-libs/gtk+-2.12
	>=dev-libs/glib-2.18"

RDEPEND="${DEP}
	espeak? ( >=app-accessibility/espeak-1.29 )
	festival? ( =app-accessibility/festival-1.96_beta )"

DEPEND="${DEP}
	>=dev-util/intltool-0.22
	virtual/pkgconfig
	dev-libs/libsigc++"

src_prepare(){
	epatch "${FILESDIR}/stardict-3.0.3-zlib-1.2.5.2.patch"
	epatch "${FILESDIR}/stardict-3.0.4-gmodule.patch"
}

src_configure(){
	G2CONF="--disable-esd-support
		$(use_enable gnome gnome-support)
		$(use_enable spell)
		$(use_enable gucharmap)
		$(use_enable espeak espeak)
		$(use_enable gpe gpe-support)
		$(use_enable qqwry)
		$(use_enable espeak)
		$(use_enable festival)
		--disable-tools
		--disable-advertisement
		--disable-updateinfo
		"
	if use gnome ; then
		G2CONF+="--enable-scrollkeeper "
	else
		G2CONF+="--disable-scrollkeeper "				
	fi
	gnome2_src_configure
}

pkg_postinst() {
	elog "Note: tts plugins are not built. For additional info, please see:"
	elog "http://r0bertz.blogspot.com/2007/11/myths-about-stardict-301s-text-to.html"
	elog "If you wish to enable tts engine, please enable 'Use TTS program.' at:"
	elog "Preferences -> Dictionary -> Sound and fill in Commandline with:"
	elog "\"echo %s | festival > --tts\" or \"espeak %s\" depending on your taste"
	elog
	elog "Also note: >=x11-libs/gtk+-2.12 is a requirement of stardict-3.0.2"
	elog "If you are using stable branch, you can emerge autounmask and use"
	elog "this command to unmask x11-libs/gtk+-2.12:"
	elog "	autounmask x11-libs/gtk+-2.12.1-r1"
	elog
	elog "You will now need to install stardict dictionary files. If"
	elog "you have not, execute the below to get a list of dictionaries:"
	elog
	elog "  emerge -s stardict-"
	elog
	ewarn "If you upgraded from 2.4.1 or lower and use your own dictionary"
	ewarn "files, you'll need to run: /usr/share/stardict/tools/stardict_dict_update"
}
