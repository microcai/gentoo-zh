# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="LLDB Machine Interface Driver"
HOMEPAGE="https://github.com/lldb-tools/lldb-mi"

EGIT_REPO_URI="https://github.com/lldb-tools/lldb-mi.git"

EGIT_BRANCH="main"

inherit git-r3 cmake

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"
#KEYWORDS="amd64"

DEPEND="
	llvm-core/llvm:=
	llvm-core/lldb
"
RDEPEND="${DEPEND}"
