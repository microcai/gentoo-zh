# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd
GIT_COMMIT="ae69847"

DESCRIPTION="A file list/WebDAV program that supports multiple storages"
HOMEPAGE="https://alist.nn.ci"
SRC_URI="
	https://github.com/alist-org/alist/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/alist-org/alist-web/releases/download/${PV}/dist.tar.gz -> ${P}-dist.tar.gz
	https://github.com/liangyongxiang/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

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
