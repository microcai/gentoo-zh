# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit flag-o-matic toolchain-funcs cargo git-r3

#MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

KEYWORDS=""
EGIT_REPO_URI="https://github.com/rust-lang/rust-analyzer.git"

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-analyzer/rust-analyzer/"

LICENSE="BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2
Boost-1.0 CC0-1.0 ISC MIT Unlicense ZLIB
"

RESTRICT="mirror"

DEPEND="
	|| (
		>=dev-lang/rust-1.63.0[rust-src]
		>=dev-lang/rust-bin-1.63.0[rust-src]
	)
	clang? (
		>=sys-devel/clang-13:=
		>=sys-devel/lld-13
	)
"
RDEPEND="${DEPEND}"

SLOT="0"
IUSE="+clang lto"
REQUIRED_USE="lto? ( !debug )"

#S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	# Show flags set at the beginning
	einfo "Current BINDGEN_CFLAGS:\t${BINDGEN_CFLAGS:-no value set}"
	einfo "Current CFLAGS:\t\t${CFLAGS:-no value set}"
	einfo "Current CXXFLAGS:\t\t${CXXFLAGS:-no value set}"
	einfo "Current LDFLAGS:\t\t${LDFLAGS:-no value set}"
	einfo "Current RUSTFLAGS:\t\t${RUSTFLAGS:-no value set}"

	local have_switched_compiler=
	if use clang && ! tc-is-clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		have_switched_compiler=yes
		AR=llvm-ar
		AS=llvm-as
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		NM=llvm-nm
		RANLIB=llvm-ranlib
		LD=ld.lld
	elif ! use clang && ! tc-is-gcc ; then
		# Force gcc
		have_switched_compiler=yes
		einfo "Enforcing the use of gcc due to USE=-clang ..."
		AR=gcc-ar
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		NM=gcc-nm
		RANLIB=gcc-ranlib
		LD=ld.bfd
	fi

	if [[ -n "${have_switched_compiler}" ]] ; then
		# Because we switched active compiler we have to ensure
		# that no unsupported flags are set
		strip-unsupported-flags
	fi

	# Ensure we use correct toolchain
	export HOST_CC="$(tc-getBUILD_CC)"
	export HOST_CXX="$(tc-getBUILD_CXX)"
	tc-export CC CXX LD AR NM OBJDUMP RANLIB
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	export CFG_RELEASE="0.3.${PV}-standalone (Custom)"

	if use clang; then
		# include RUSTFLAGS from portage (e.g. make.conf)
		export RUSTFLAGS="${RUSTFLAGS} -C link-arg=-fuse-ld=lld -C target-feature=-crt-static"
	fi

	if use lto; then
		if use clang; then
			export CARGO_PROFILE_RELEASE_LTO="thin"
		else
			export CARGO_PROFILE_RELEASE_LTO="true"
		fi
	fi

	cargo_src_compile
}

src_test() {
	# Requires out of source git repo.
	cargo_src_test -- --skip "tidy::check_merge_commits"
}

src_install() {
	cargo_src_install --path "./crates/rust-analyzer"

	dodoc README.md
}
