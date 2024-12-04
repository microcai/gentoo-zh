# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module systemd

DESCRIPTION="A swiss army knife for Debian repository management"
HOMEPAGE="https://github.com/aptly-dev/aptly"
SRC_URI="https://github.com/aptly-dev/aptly/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/liuyujielol/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # fails

RDEPEND="
	acct-group/aptly
	acct-user/aptly
"

src_compile() {
	ego build -mod=readonly -o cmd/aptly -ldflags "-X main.Version=${PV}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin cmd/aptly
	doman man/aptly.1
	dobashcomp completion.d/aptly
	insinto /usr/share/zsh/site-functions
	doins completion.d/_aptly
	systemd_dounit aptly-api.service
	systemd_dounit aptly.service
	newinitd "${FILESDIR}"/aptly.initd aptly
	newconfd "${FILESDIR}"/aptly.confd aptly
	newinitd "${FILESDIR}"/aptly-api.initd aptly-api
	newconfd "${FILESDIR}"/aptly-api.confd aptly-api

	diropts -o aptly -g aptly -m 0700
	keepdir /etc/aptly
	insopts -o aptly -g aptly -m 0644
	insinto /etc/aptly
	doins "${FILESDIR}"/aptly.conf
}
