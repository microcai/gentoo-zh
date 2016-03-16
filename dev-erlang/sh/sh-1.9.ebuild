# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="Family of functions and ports involving interacting with the system shell, paths and external programs"
HOMEPAGE="https://github.com/synrc/sh"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/synrc/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/synrc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="synrc-sh"
SLOT="0"
IUSE="doc src"

RDEPEND="dev-lang/erlang"
DEPEND="${DEPEND}
	dev-util/rebar"

src_compile() {
	rebar compile

	if use doc ; then
		rebar doc
	fi
}

src_install() {
	erlang-pkg_doebin

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
