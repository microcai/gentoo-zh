# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LLDB Machine Interface Driver"
HOMEPAGE="https://github.com/lldb-tools/lldb-mi"
SRC_URI="
	https://github.com/lldb-tools/lldb-mi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	llvm-core/llvm:=
	llvm-core/lldb
"
RDEPEND="${DEPEND}"
