# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="Ibrowse is a HTTP client written in Erlang"
HOMEPAGE="https://github.com/cmullaparthi/ibrowse"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/cmullaparthi/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/cmullaparthi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( BSD LGPL )"
SLOT="0"
IUSE="doc src"

DEPEND="dev-lang/erlang"
RDEPEND="${DEPEND}"

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
