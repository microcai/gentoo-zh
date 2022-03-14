# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo git-r3

#MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

KEYWORDS=""
EGIT_REPO_URI="https://github.com/rust-analyzer/rust-analyzer"

DESCRIPTION="An experimental Rust compiler front-end for IDEs "
HOMEPAGE="https://github.com/rust-analyzer/rust-analyzer"

LICENSE="BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2
Boost-1.0 CC0-1.0 ISC MIT Unlicense ZLIB
"

RESTRICT="mirror"

DEPEND="|| ( >=dev-lang/rust-1.54.0[rls] >=dev-lang/rust-bin-1.54.0[rls] )"
RDEPEND="${DEPEND}"
SLOT="0"

#S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	cargo_src_install --path "./crates/rust-analyzer"

	dodoc README.md
}
