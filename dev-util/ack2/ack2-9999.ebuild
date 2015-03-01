# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-app

DESCRIPTION="A greplike tool optimized for programmers searching large heterogeneous trees of source code"
HOMEPAGE="http://beyondgrep.com/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/petdance/${PN}.git"
	EGIT_BRANCH="dev"
	KEYWORDS=""
else
	SRC_URI="https://github.com/petdance/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi

LICENSE="Artistic-2"
SLOT="0"
IUSE="standalone"

DEPEND=">=dev-lang/perl-5.8.8"
RDEPEND="${DEPEND}
	dev-perl/File-Next"

src_compile() {
	if use standalone ; then
		emake ack-standalone
	else
		perl-app_src_compile
	fi
}

src_install() {
	if use standalone ; then
		newbin ack-standalone ack
	else
		perl-module_src_install
	fi
}
