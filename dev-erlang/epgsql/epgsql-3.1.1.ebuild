# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="Erlang PostgreSQL client library"
HOMEPAGE="https://github.com/epgsql/epgsql"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/epgsql/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/epgsql/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="epgsql"
SLOT="0"
IUSE="src"

RDEPEND="dev-lang/erlang"
DEPEND="${DEPEND}
	dev-util/rebar"

src_compile() {
	emake
}

src_install() {
	erlang-pkg_doebin

	if use src ; then
		erlang-pkg_dosrc
	fi
}
