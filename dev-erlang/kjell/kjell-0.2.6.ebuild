# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="A refurbished Erlang shell with support for color profiles and extensions."
HOMEPAGE="https://github.com/karlll/kjell"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/karlll/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/karlll/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ErlPL-1.1"
SLOT="0"
IUSE="doc src"

DEPEND=">=dev-lang/erlang-16.3.1"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '13a docs:\n\t@$(REBAR) doc' Makefile
}

src_compile() {
	emake

	if use doc ; then
		emake docs
	fi
}

src_install() {
	dobin "${FILESDIR}/kjell"

	erlang-pkg_doebin
	erlang-pkg_doinclude

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
