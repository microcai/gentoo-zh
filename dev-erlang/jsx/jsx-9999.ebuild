# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="An erlang application for consuming, producing and manipulating json."
HOMEPAGE="https://github.com/talentdeficit/jsx"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/talentdeficit/${PN}.git"
	EGIT_BRANCH="develop"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/talentdeficit/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc src"

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
	dev-erlang/rebar"

src_prepare() {
	sed -i '5adocs:\n\trebar doc' Makefile
}

src_compile() {
	emake

	if use doc ; then
		emake docs
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
