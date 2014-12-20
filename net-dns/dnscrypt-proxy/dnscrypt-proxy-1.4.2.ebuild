# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic systemd user ${GIT_ECLASS}

DESCRIPTION="A tool for securing communications between a client and a DNS resolver"
HOMEPAGE="http://dnscrypt.org/"
RESTRICT="mirror"

LICENSE="ISC"
SLOT="0"
if [[ ${PV} == "9999" ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/jedisct1/${PN}"
	KEYWORDS=""
else
	SRC_URI="http://download.dnscrypt.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
IUSE="+plugins ldns systemd"

DEPEND=""
RDEPEND="dev-libs/libsodium
	ldns? ( net-libs/ldns )
	systemd? ( sys-apps/systemd )"

DOCS=( AUTHORS ChangeLog COPYING NEWS README.markdown README-PLUGINS.markdown
	TECHNOTES THANKS )

pkg_setup() {
	enewgroup dnscrypt
	enewuser dnscrypt -1 -1 /var/empty dnscrypt
}

src_configure() {
	econf $(use_enable plugins) \
		$(use_with systemd )
}

src_install() {
	default

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	if use systemd; then
		systemd_dounit "${FILESDIR}"/${PN}.service
	fi
}
