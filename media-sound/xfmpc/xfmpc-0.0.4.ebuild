# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit xfce44

DESCRIPTION="A graphical GTK+ MPD client focusing on low footprint" 
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfmpc"     
SRC_URI="http://goodies.xfce.org/releases/xfmpc/${P}.tar.bz2"
SLOT="0" 
IUSE=""
RESTRICT="mirror"  #for overlay
LICENSE="GPL-2" 
KEYWORDS="x86 amd64" 

#http://gentoo-overlays.zugaina.org/xfce/portage/xfce-extra/xfmpc/xfmpc-9999.ebuild
RDEPEND=">=x11-libs/gtk+-2.12 \
	  >=xfce-base/libxfcegui4-4.4.0 \
     >=xfce-base/libxfce4util-4.4.0 \
	  >=media-libs/libmpd-0.15.0 "

DEPEND="${RDEPEND} \
  dev-util/intltool"


