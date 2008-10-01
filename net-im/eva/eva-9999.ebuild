# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="https://evaq.svn.sourceforge.net/svnroot/evaq/branches/eva-qt3-bugfix/eva/"

inherit kde subversion

DESCRIPTION="A kde implement of QQ"
SRC_URI=""
HOMEPAGE="http://sourceforge.net/projects/evaq"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/eva

need-kde 3
