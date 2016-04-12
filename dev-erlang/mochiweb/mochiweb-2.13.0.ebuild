# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="An Erlang library for building lightweight HTTP servers."
HOMEPAGE="https://github.com/mochi/mochiweb"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mochi/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mochi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc src"

DEPEND="dev-lang/erlang"
RDEPEND="${DEPEND}"

src_compile() {
	emake

	if use doc ; then
		emake edoc
	fi
}

src_install() {
	erlang-pkg_doebin
	erlang-pkg_doinclude

	erlang-pkg_docustom "scripts" "support"

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
