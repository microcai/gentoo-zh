# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.15.2
adler-1.0.2
always-assert-0.1.2
ansi_term-0.12.1
anyhow-1.0.42
anymap-0.12.1
arrayvec-0.7.1
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.60
bitflags-1.2.1
camino-1.0.4
cargo-platform-0.1.1
cargo_metadata-0.14.0
cc-1.0.68
cfg-if-1.0.0
chalk-derive-0.69.0
chalk-ir-0.69.0
chalk-recursive-0.69.0
chalk-solve-0.69.0
countme-2.0.4
cov-mark-2.0.0-pre.1
crc32fast-1.2.1
crossbeam-channel-0.5.1
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.5
crossbeam-utils-0.8.5
dashmap-4.0.2
dissimilar-1.0.2
dot-0.1.4
drop_bomb-0.1.5
either-1.6.1
ena-0.14.0
env_logger-0.8.4
expect-test-1.1.0
filetime-0.2.14
fixedbitset-0.2.0
flate2-1.0.20
form_urlencoded-1.0.1
fs_extra-1.2.0
fsevent-sys-4.0.0
fst-0.4.7
gimli-0.24.0
hashbrown-0.11.2
heck-0.3.3
hermit-abi-0.1.19
home-0.5.3
idna-0.2.3
indexmap-1.7.0
inotify-0.9.3
inotify-sys-0.1.5
instant-0.1.9
itertools-0.10.1
itoa-0.4.7
jod-thread-0.1.2
lazy_static-1.4.0
libc-0.2.98
libloading-0.7.0
libmimalloc-sys-0.1.22
lock_api-0.4.4
log-0.4.14
lsp-server-0.5.2
lsp-types-0.89.2
matchers-0.0.1
matches-0.1.8
memchr-2.4.0
memmap2-0.3.0
memoffset-0.6.4
mimalloc-0.1.26
miniz_oxide-0.4.4
mio-0.7.13
miow-0.3.7
notify-5.0.0-pre.10
ntapi-0.3.6
num_cpus-1.13.0
object-0.25.3
once_cell-1.8.0
oorandom-11.1.3
parking_lot-0.11.1
parking_lot_core-0.8.3
paste-0.1.18
paste-impl-0.1.18
percent-encoding-2.1.0
perf-event-0.4.7
perf-event-open-sys-1.0.1
petgraph-0.5.1
pin-project-lite-0.2.7
proc-macro-hack-0.5.19
proc-macro2-1.0.27
pulldown-cmark-0.8.0
pulldown-cmark-to-cmark-6.0.2
quote-1.0.9
rayon-1.5.1
rayon-core-1.9.1
redox_syscall-0.2.9
regex-1.5.4
regex-automata-0.1.10
regex-syntax-0.6.25
rowan-0.13.0-pre.7
rustc-ap-rustc_lexer-725.0.0
rustc-demangle-0.1.20
rustc-hash-1.1.0
ryu-1.0.5
salsa-0.17.0-pre.1
salsa-macros-0.17.0-pre.1
same-file-1.0.6
scoped-tls-1.0.0
scopeguard-1.1.0
semver-1.0.3
serde-1.0.126
serde_derive-1.0.126
serde_json-1.0.64
serde_path_to_error-0.1.4
serde_repr-0.1.7
sharded-slab-0.1.1
smallvec-1.6.1
smol_str-0.1.18
snap-1.0.5
syn-1.0.73
synstructure-0.12.4
termcolor-1.1.2
text-size-1.1.0
thread_local-1.1.3
threadpool-1.8.1
tikv-jemalloc-ctl-0.4.1
tikv-jemalloc-sys-0.4.1+5.2.1-patched
tikv-jemallocator-0.4.1
tinyvec-1.2.0
tinyvec_macros-0.1.0
tracing-0.1.26
tracing-attributes-0.1.15
tracing-core-0.1.18
tracing-log-0.1.2
tracing-subscriber-0.2.19
tracing-tree-0.1.9
ungrammar-1.14.1
unicase-2.6.0
unicode-bidi-0.3.5
unicode-normalization-0.1.19
unicode-segmentation-1.8.0
unicode-xid-0.2.2
url-2.2.2
version_check-0.9.3
walkdir-2.3.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
write-json-0.1.2
xflags-0.2.2
xflags-macros-0.2.2
xshell-0.1.14
xshell-macros-0.1.14
"

DESCRIPTION="An experimental Rust compiler front-end for IDEs "
HOMEPAGE="https://github.com/rust-analyzer/rust-analyzer"
EGIT_REPO_URI="https://github.com/rust-analyzer/rust-analyzer"
inherit cargo

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	SRC_URI="
		${EGIT_REPO_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})
	"
fi

LICENSE="BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2
Boost-1.0 CC0-1.0 ISC MIT Unlicense ZLIB
"

RESTRICT="mirror"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/rust-1.46.0[rls]"
RDEPEND="${DEPEND}"
SLOT="0"
IUSE=""

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
		mv -T "${PN}-${MY_PV}" "${P}" || die
	fi
}

src_install() {
	cargo_src_install --path "./crates/rust-analyzer"

	dodoc README.md
}
