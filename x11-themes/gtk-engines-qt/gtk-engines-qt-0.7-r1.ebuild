# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.7-r1.ebuild,v 1.4 2007/03/22 16:46:06 jokey Exp $

inherit kde eutils subversion

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"

DEPEND="${DEPEND}
	dev-util/cmake
	>=x11-libs/gtk+-2.2"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

#S=${WORKDIR}/${MY_PN}/
setproxy()
{
	if [ -n "$http_proxy" ]
	then
		porxy_host=`echo $http_proxy |cut -d: -f-2`
		porxy_port=`echo $http_proxy |cut -d: -f3`
		mkdir $HOME/.subversion
		echo "http-proxy-host = $porxy_host" >${ESVN_STORE_DIR}/.subversion/servers
		echo "http-proxy-port = $porxy_host" >>${ESVN_STORE_DIR}/.subversion/servers
		einfo "set subversion proxy to $porxy_host:$porxy_port"
	fi
}
src_unpack() {
	#setproxy
	ESVN_REPO_URI="http://gtk-qt.ecs.soton.ac.uk/svn/gtk-qt/trunk/gtk-qt-engine"
	ESVN_PROJECT="${P}"
	#ESVN_PATCHES="*.diff"
	#ESVN_BOOTSTRAP="./autogen.sh"
	subversion_src_unpack
	cd ${S}
#	epatch ${FILESDIR}/gtk-engines-qt-0.7-implicit.patch
#	epatch ${FILESDIR}/kcmgtk-write-good-bashrc.diff
}

src_install() {
	kde_src_install
	# remove duplicate .desktop
	rm ${D}/usr/share/applnk/Settings/LookNFeel/kcmgtk.desktop
	# Add environment variable
	dodir /etc/X11/xinit/xinitrc.d
	echo 'export GTK2_RC_FILES="$HOME/.gtkrc-2.0:$HOME/.kde/share/config/gtkrc-2.0:/etc/gtk-2.0/gtkrc"' \
		>> ${D}/etc/X11/xinit/xinitrc.d/${PN}
	fperms a+x /etc/X11/xinit/xinitrc.d/${PN}
}

pkg_postinst() {
	ewarn "This crashes gnome, see http://bugs.gentoo.org/105092"
}
