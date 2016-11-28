# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="A logging framework for Erlang/OTP"
HOMEPAGE="http://basho.com"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/basho/lager.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/basho/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc src"

DEPEND=">=dev-lang/erlang-17.3
	=dev-erlang/goldrush-0.1.6"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '4,5d' rebar.config

	sed -i -e '1s/deps/deps doc/' \
		-e '11a doc:\n\t./rebar doc\n' Makefile
}

src_compile() {
	emake

	if use doc ; then
		emake doc
	fi
}

src_install() {
	erlang-pkg_doebin

	if use src ; then
		erlang-pkg_dosrc
	fi
}
