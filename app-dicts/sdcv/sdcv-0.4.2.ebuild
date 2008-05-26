# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-dicts/sdcv/sdcv-0.4.2.ebuild,v 1.1 2006/10/11 08:02:18 scsi Exp $

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

inherit eutils

IUSE=""
DESCRIPTION="An console version of StarDict program."
#HOMEPAGE="http://stardict.sourceforge.net/ http://cosoft.org.cn/projects/stardict/"
HOMEPAGE="http://sdcv.sourceforge.net/" 
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="x86 ~pcc ~amd64"

RDEPEND=">=dev-libs/glib-2.0"

DEPEND="${RDEPEND}"

src_install()
{
	cd ${S}
	make DESTDIR=${D} install || die
}
pkg_postinst() {
	einfo "You will now need to install stardict dictionary files. If"
	einfo "you have not, execute the below to get a list of dictionaries:"
	echo
	einfo "  emerge -s stardict-"
	echo
	einfo "If you do not want to install stardic. You need download "
	einfo "stardict dictionary files manually from"
	einfo "http://stardict.sourceforge.net/Dictionaries.php and put then in"
	einfo " ~/.stardict/dic"
}
