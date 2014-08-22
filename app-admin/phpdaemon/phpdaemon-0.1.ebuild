# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5


DESCRIPTION="php script daemon"
HOMEPAGE="https://github.com/bobchengbin/phpdaemon"
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/bobchengbin/phpdaemon.git"
inherit git-2 eutils

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_install(){
	dobin phpdaemon
	doinitd phpdaemon_link
	dodoc README.txt
}
