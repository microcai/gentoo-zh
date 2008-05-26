# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.7_p20070327-r2.ebuild,v 1.5 2007/08/07 07:39:56 vapier Exp $

ARTS_REQUIRED="never"

inherit kde eutils qt3

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/0.8/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"

DEPEND="${DEPEND}
	$(qt_min_version 3.3.8)
	>=x11-libs/gtk+-2.2
	dev-util/cmake"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S=${WORKDIR}/${MY_PN}

src_install() {
	kde_src_install
	mv "${D}"/usr/local/share/{locale,applications} "${D}"/usr/share/ || die
}
