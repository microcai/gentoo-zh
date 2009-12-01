# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde subversion

ESVN_REPO_URI="https://evaq.svn.sourceforge.net/svnroot/evaq/branches/eva-qt3-bugfix/eva/"

DESCRIPTION="A kde implement of QQ"
HOMEPAGE="http://sourceforge.net/projects/evaq"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/eva

need-kde 3
