# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="Non-blocking Redis client with focus on performance and robustness"
HOMEPAGE="https://github.com/wooga/eredis"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/wooga/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/wooga/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="src"

DEPEND="dev-lang/erlang"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	erlang-pkg_doebin

	if use src ; then
		erlang-pkg_dosrc
	fi
}
