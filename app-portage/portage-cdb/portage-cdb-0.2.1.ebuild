# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="increase portage's speed after syncing, and for calculating dependencies. This method uses a database, rather than a bunch of flat files to store its metadata."
HOMEPAGE="http://gentoo-wiki.com/TIP_speed_up_portage_with_cdb"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-apps/portage-2.1
		dev-python/python-cdb"
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

	insinto /usr/lib/portage/pym/cache
	doins ${FILESDIR}/cdb.py

	insinto /etc/portage
	newins ${FILESDIR}/modules-2.1 modules
}

pkg_postinst()
{
	ebegin "emerge metadata"
		emerge --metadata
	eend
	einfo
	einfo "# New updates to portage will be much faster, and if you use "
	einfo "  emerge --searchdesc then you'll definately notice a speedup as well."
	einfo "# If you want to turn this off, just comment out the two lines we" 
	einfo "  added in  /etc/portage/modules."
	einfo "# According to DirtyEpic on the Gentoo Forums, upgrading to"
	einfo "  python-2.4 will break portage. Comment out your /etc/modules file,"
	einfo "  and remerge portage and cdb to fix it."
}
