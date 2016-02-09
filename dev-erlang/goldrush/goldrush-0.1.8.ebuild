# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="Small, Fast event processing and monitoring for Erlang/OTP applications"
HOMEPAGE="https://github.com/DeadZen/goldrush"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/DeadZen/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/DeadZen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="goldrush"
SLOT="0"
IUSE="src doc"

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
	dev-util/rebar"

src_compile() {
	emake

	if use doc ; then
		emake docs
	fi
}

src_install() {
	erlang-pkg_doebin

	if use src ; then
		erlang-pkg_dosrc
	fi

	if use doc ; then
		erlang-pkg_dodoc
	fi
}
