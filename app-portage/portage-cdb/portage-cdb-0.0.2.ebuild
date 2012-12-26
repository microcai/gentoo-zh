# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="increase portage's speed after syncing, and for calculating dependencies. This method uses a database, rather than a bunch of flat files to store its metadata."
HOMEPAGE="http://gentoo-wiki.com/TIP_speed_up_portage_with_cdb http://gentoo-wiki.com/TIP_Speed_up_portage_with_Psyco"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"
IUSE="psyco"

DEPEND="<sys-apps/portage-2.1
		dev-python/python-cdb
		psyco? ( dev-python/psyco )"
RDEPEND=""

src_unpack()
{
	einfo "no need unpack."
}
src_compile()
{
	einfo "no need compile."
}
src_install()
{
	insinto /usr/lib/portage/pym
	doins ${FILESDIR}/portage_db_cdb.py

	insinto /etc/portage
	doins ${FILESDIR}/modules
}

pkg_postinst()
{
	ebegin "emerge metadata"
		emerge metadata
	eend
	einfo
	einfo "# New updates to portage will be much faster, and if you use "
	einfo "  emerge --searchdesc then you'll definately notice a speedup as well."
	einfo "# If you want to turn this off, just comment out the two lines we" 
	einfo "  added in  /etc/portage/modules."
	einfo "# According to DirtyEpic on the Gentoo Forums, upgrading to"
	einfo "  python-2.4 will break portage. Comment out your /etc/modules file,"
	einfo "  and remerge portage and cdb to fix it."

	if use psyco
	then
		einfo "Note: To make use of psyco, you must edit your /usr/bin/emerge"
		einfo "(or other python program you want to speed up) to include it:"
		einfo "---"
		einfo "#!/usr/bin/python -O"
		einfo "# Copyright 1999-2004 Gentoo Foundation"
		einfo "# Distributed under the terms of the GNU General Public License v2"
		einfo ""
		einfo "import os,sys"
		einfo "os.environ[\"PORTAGE_CALLER\"]=\"emerge\""
		einfo "sys.path = [\"/usr/lib/portage/pym\"]+sys.path"
		einfo ""
		einfo "import portage"
		einfo "#Added for Psyco"
		einfo "try:"
		einfo "       import psyco"
		einfo "       psyco.full()"
		einfo "except ImportError:"
		einfo "       pass"
		einfo "#Done"
		einfo ""
		einfo "import emergehelp,xpak,string,re,commands,time,shutil,traceback,atexit,signal,socket,types"
		einfo "---"
		einfo ""
		einfo "for detail, please visit "
		einfo "http://gentoo-wiki.com/TIP_Speed_up_portage_with_Psyco" 
		einfo ""
	fi
}
