# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
"

inherit cargo

DESCRIPTION="Upload video to bilibili"
HOMEPAGE="https://github.com/biliup/biliup-rs"
SRC_URI="
	https://github.com/biliup/biliup-rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://distfiles.gentoocn.org/~jinqiang/distfiles/biliup-${PV}-crates.tar.xz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT MPL-2.0
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug"
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	dobin $(cargo_target_dir)/biliup
}
