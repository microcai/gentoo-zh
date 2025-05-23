# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A key remapping daemon for linux"
HOMEPAGE="https://github.com/rvaiya/keyd"
SRC_URI="https://github.com/rvaiya/keyd/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="acct-group/keyd"
RDEPEND="$DEPEND"

src_prepare() {
	sed -i "/-groupadd keyd/d" Makefile || die
	default
}

src_install() {
	default
	# prevent docs from being installed to /usr/local/share/doc
	rm -r "${D}"/usr/local/share/{man,doc} || die
	dodoc docs/{CHANGELOG.md,DESIGN.md}
	systemd_dounit keyd.service
	insinto /etc/keyd
	doins "${FILESDIR}"/default.conf
	gzip -d data/{keyd,keyd-application-mapper}.1.gz || die
	doman data/{keyd,keyd-application-mapper}.1
}
