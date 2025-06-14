# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature

DESCRIPTION="AI coding agent, built for the terminal"
HOMEPAGE="https://github.com/opencode-ai/opencode"
SRC_URI="
	https://github.com/opencode-ai/opencode/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/douglarek/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"
S="${WORKDIR}"/${P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X github.com/opencode-ai/opencode/internal/version.Version=${PV}"
	ego build -o ${PN} -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	optfeature_header "Some features may be limited or slower without the following optional dependencies:"
	optfeature "improved search functionality" sys-apps/ripgrep
	optfeature "enhanced command line interaction" app-shells/fzf
}
