# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils erlang-pkg

DESCRIPTION="A driver for connecting Erlang/OTP applications to MySQL databases."
HOMEPAGE="https://github.com/mysql-otp/mysql-otp"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mysql-otp/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mysql-otp/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL3"
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
	erlang-pkg_doinclude

	if use doc ; then
		erlang-pkg_dodoc
	fi

	if use src ; then
		erlang-pkg_dosrc
	fi
}
