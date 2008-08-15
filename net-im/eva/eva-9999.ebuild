# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#ECVS_AUTH="pserver"
#ECVS_SERVER="evaq.cvs.sourceforge.net:/cvsroot/evaq"
#ECVS_MODULE="eva"
#inherit kde eutils cvs
ESVN_REPO_URI="https://evaq.svn.sourceforge.net/svnroot/evaq/branches/eva-qt3-bugfix"

inherit kde eutils subersion

S=${WORKDIR}/eva

DESCRIPTION="A kde implement of QQ"
SRC_URI=""
HOMEPAGE="http://sourceforge.net/projects/evaq"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
need-kde 3
