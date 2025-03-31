# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

GIT_COMMIT="0cde4e7"
ALIST_WEBVER="3.44.0"
DESCRIPTION="A file list/WebDAV program that supports multiple storages"
HOMEPAGE="https://alist.nn.ci"
SRC_URI="
	https://github.com/AlistGo/alist/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/AlistGo/alist-web/releases/download/${ALIST_WEBVER}/dist.tar.gz -> ${P}-dist.tar.gz
	https://github.com/Linerre/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/alist
	acct-user/alist
"

QA_PRESTRIPPED="/usr/bin/${PN}"

src_prepare() {
	rm -rf public/dist || die
	mv "${WORKDIR}/dist" public || die
	default
}

src_compile() {
	local ldflags="\
		-X 'github.com/alist-org/alist/v3/internal/conf.BuiltAt=$(date +'%F %T %z')' \
		-X 'github.com/alist-org/alist/v3/internal/conf.GoVersion=$(go version | cut -d ' ' -f 3)' \
		-X 'github.com/alist-org/alist/v3/internal/conf.GitAuthor=\"Xhofe <i@nn.ci>\"' \
		-X 'github.com/alist-org/alist/v3/internal/conf.GitCommit=${GIT_COMMIT}' \
		-X 'github.com/alist-org/alist/v3/internal/conf.Version=${PV}' \
		-X 'github.com/alist-org/alist/v3/internal/conf.WebVersion=${PV}' \
		-w -s"
	ego build -o ${PN} -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
	systemd_dounit "${FILESDIR}/alist.service"
}
