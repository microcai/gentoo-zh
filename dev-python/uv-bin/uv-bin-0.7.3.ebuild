# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker
DESCRIPTION="An extremely fast Python package and project manager, written in Rust."
HOMEPAGE="https://github.com/astral-sh/uv"
SRC_URI="
	amd64? (
		elibc_glibc? ( https://github.com/astral-sh/uv/releases/download/${PV}/uv-x86_64-unknown-linux-gnu.tar.gz )
		elibc_musl? ( https://github.com/astral-sh/uv/releases/download/${PV}/uv-x86_64-unknown-linux-musl.tar.gz )
	)
"

S="${WORKDIR}"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"
DEPEND="
	!dev-python/uv
	elibc_glibc? ( sys-libs/glibc )
	elibc_musl? ( sys-libs/musl )
"
RDEPEND="${DEPEND}"

src_install() {
	if use elibc_glibc ; then
		dir="uv-x86_64-unknown-linux-gnu"
	elif use elibc_musl ; then
		dir="uv-x86_64-unknown-linux-musl"
	else
		die "Unsupported libc"
	fi

	dobin "${dir}/uv" "${dir}/uvx"
}
