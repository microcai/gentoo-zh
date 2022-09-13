# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	always-assert-0.1.2
	ansi_term-0.12.1
	anyhow-1.0.62
	anymap-1.0.0-beta.2
	arbitrary-1.1.3
	arrayvec-0.7.2
	atty-0.2.14
	autocfg-1.1.0
	backtrace-0.3.66
	bitflags-1.3.2
	camino-1.1.1
	cargo-platform-0.1.2
	cargo_metadata-0.15.0
	cc-1.0.73
	cfg-if-1.0.0
	chalk-derive-0.84.0
	chalk-ir-0.84.0
	chalk-recursive-0.84.0
	chalk-solve-0.84.0
	countme-3.0.1
	cov-mark-2.0.0-pre.1
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	dashmap-5.3.4
	derive_arbitrary-1.1.3
	dissimilar-1.0.4
	dot-0.1.4
	drop_bomb-0.1.5
	either-1.8.0
	ena-0.14.0
	expect-test-1.4.0
	filetime-0.2.17
	fixedbitset-0.2.0
	flate2-1.0.24
	form_urlencoded-1.0.1
	fs_extra-1.2.0
	fsevent-sys-4.1.0
	fst-0.4.7
	gimli-0.26.2
	hashbrown-0.12.3
	heck-0.3.3
	hermit-abi-0.1.19
	home-0.5.3
	idna-0.2.3
	indexmap-1.9.1
	inotify-0.9.6
	inotify-sys-0.1.5
	instant-0.1.12
	itertools-0.10.3
	itoa-1.0.3
	jod-thread-0.1.2
	kqueue-1.0.6
	kqueue-sys-1.0.3
	lazy_static-1.4.0
	libc-0.2.132
	libloading-0.7.3
	libmimalloc-sys-0.1.25
	lock_api-0.4.7
	log-0.4.17
	lsp-types-0.93.1
	matchers-0.1.0
	matches-0.1.9
	memchr-2.5.0
	memmap2-0.5.7
	memoffset-0.6.5
	mimalloc-0.1.29
	miniz_oxide-0.5.3
	mio-0.8.4
	miow-0.4.0
	notify-5.0.0-pre.16
	num_cpus-1.13.1
	object-0.29.0
	once_cell-1.13.1
	oorandom-11.1.3
	parking_lot-0.11.2
	parking_lot-0.12.1
	parking_lot_core-0.8.5
	parking_lot_core-0.9.3
	paste-1.0.8
	percent-encoding-2.1.0
	perf-event-0.4.7
	perf-event-open-sys-1.0.1
	petgraph-0.5.1
	pin-project-lite-0.2.9
	proc-macro2-1.0.43
	protobuf-3.1.0
	protobuf-support-3.1.0
	pulldown-cmark-0.9.2
	pulldown-cmark-to-cmark-10.0.2
	quote-1.0.21
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.16
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	rowan-0.15.8
	rustc-ap-rustc_lexer-725.0.0
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	ryu-1.0.11
	salsa-0.17.0-pre.2
	salsa-macros-0.17.0-pre.2
	same-file-1.0.6
	scip-0.1.1
	scoped-tls-1.0.0
	scopeguard-1.1.0
	semver-1.0.13
	serde-1.0.143
	serde_derive-1.0.143
	serde_json-1.0.83
	serde_repr-0.1.9
	sharded-slab-0.1.4
	smallvec-1.9.0
	smol_str-0.1.23
	snap-1.0.5
	syn-1.0.99
	synstructure-0.12.6
	text-size-1.1.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	thread_local-1.1.4
	threadpool-1.8.1
	tikv-jemalloc-ctl-0.5.0
	tikv-jemalloc-sys-0.5.1+5.3.0-patched
	tikv-jemallocator-0.5.0
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tracing-0.1.36
	tracing-attributes-0.1.22
	tracing-core-0.1.29
	tracing-log-0.1.3
	tracing-subscriber-0.3.15
	tracing-tree-0.2.1
	typed-arena-2.0.1
	ungrammar-1.16.1
	unicase-2.6.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.1
	unicode-normalization-0.1.21
	unicode-segmentation-1.9.0
	unicode-xid-0.2.3
	url-2.2.2
	valuable-0.1.0
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.28.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.28.0
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.28.0
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.28.0
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.28.0
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.28.0
	windows_x86_64_msvc-0.36.1
	write-json-0.1.2
	xflags-0.2.4
	xflags-macros-0.2.4
	xshell-0.2.2
	xshell-macros-0.2.2
	xtask-0.1.0
"

inherit flag-o-matic toolchain-funcs cargo

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

KEYWORDS="~amd64"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

DESCRIPTION="An experimental Rust compiler front-end for IDEs "
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

S="${WORKDIR}/${PN}-${MY_PV}"

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
