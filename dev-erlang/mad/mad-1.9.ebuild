# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="A simple rebar-compatible dependency manager"
HOMEPAGE="https://github.com/synrc/mad"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/synrc/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/synrc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Synrc-Research-Center"
SLOT="0"
IUSE="doc src"

RDEPEND="dev-lang/erlang
	dev-erlang/sh"
DEPEND="${DEPEND}"

src_prepare() {
	sed -i '2d' rebar.config
}

src_compile() {
	emake
}

src_install() {
	dobin mad

	erlang-pkg_doebin

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
