# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The open source AI coding agent"
HOMEPAGE="https://opencode.ai"

GITHUB_BASE="https://github.com/anomalyco/opencode/releases/download/v${PV}"
SRC_URI="
	amd64? (
		cpu_flags_x86_avx2? (
			elibc_glibc? ( ${GITHUB_BASE}/opencode-linux-x64.tar.gz -> ${P}-amd64.tar.gz )
			elibc_musl? ( ${GITHUB_BASE}/opencode-linux-x64-musl.tar.gz -> ${P}-amd64-musl.tar.gz )
		)
		!cpu_flags_x86_avx2? (
			elibc_glibc? ( ${GITHUB_BASE}/opencode-linux-x64-baseline.tar.gz -> ${P}-amd64-baseline.tar.gz )
			elibc_musl? ( ${GITHUB_BASE}/opencode-linux-x64-baseline-musl.tar.gz -> ${P}-amd64-baseline-musl.tar.gz )
		)
	)
	arm64? (
		elibc_glibc? ( ${GITHUB_BASE}/opencode-linux-arm64.tar.gz -> ${P}-arm64.tar.gz )
		elibc_musl? ( ${GITHUB_BASE}/opencode-linux-arm64-musl.tar.gz -> ${P}-arm64-musl.tar.gz )
	)
"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="cpu_flags_x86_avx2"
RESTRICT="mirror strip"

QA_PREBUILT="usr/bin/opencode"

src_install() {
	dobin opencode
}
