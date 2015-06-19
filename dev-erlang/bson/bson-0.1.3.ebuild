# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit erlang-pkg

_PN="${PN}-erlang"
_P="${_PN}-${PV}"

DESCRIPTION="The BSON implementation for Erlang."
HOMEPAGE="https://github.com/yunba/bson-erlang"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yunba/${_PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/yunba/${_PN}/archive/v${PV}.tar.gz -> ${_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/${_P}"
fi

LICENSE="all-rights-reserved"
SLOT="0"
IUSE="doc src"

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
	dev-lang/rebar"

src_compile() {
	rebar compile
	
	if use doc ; then
		rebar doc
	fi
}

src_install() {
	erlang-pkg_doebin
	erlang-pkg_doinclude

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
