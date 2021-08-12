# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aptly-dev/${PN}.git"

inherit bash-completion-r1 git-r3 go-module systemd

DESCRIPTION="A swiss army knife for Debian repository management"
HOMEPAGE="https://github.com/aptly-dev/aptly"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test" # fails

RDEPEND="acct-user/aptly"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -o cmd/aptly -ldflags "-X main.Version=${PV}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
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
