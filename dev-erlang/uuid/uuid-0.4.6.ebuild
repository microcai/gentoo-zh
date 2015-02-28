# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit erlang-pkg

_PN="erlang-${PN}"
_P="${_PN}-${PV}"

DESCRIPTION="This module implements UUID v1, v3, v4, and v5 as of RFC 4122."
HOMEPAGE="https://github.com/avtobiff/erlang-uuid"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/avtobiff/${_PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/avtobiff/${_PN}/archive/v${PV}.tar.gz -> ${_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/${_P}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc src"

DEPEND="${RDEPEND}
	dev-erlang/rebar"
RDEPEND="dev-lang/erlang"

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
