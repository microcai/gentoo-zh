# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@0.7.18
	ansi_term@0.12.1
	assert_cmd@2.0.4
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	bstr@0.2.17
	clap@3.1.18
	clap_complete@3.1.4
	clap_derive@3.1.18
	clap_lex@0.2.0
	difflib@0.4.0
	doc-comment@0.3.3
	either@1.6.1
	getopts@0.2.21
	hashbrown@0.12.1
	heck@0.4.0
	hermit-abi@0.1.19
	indexmap@1.9.0
	itertools@0.10.3
	itoa@1.0.1
	lazy_static@1.4.0
	libc@0.2.125
	lscolors@0.7.1
	memchr@2.5.0
	os_str_bytes@6.0.1
	predicates@2.1.1
	predicates-core@1.0.3
	predicates-tree@1.0.5
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.38
	quote@1.0.18
	regex@1.5.5
	regex-automata@0.1.10
	regex-syntax@0.6.25
	ryu@1.0.9
	same-file@1.0.6
	serde@1.0.137
	serde_derive@1.0.137
	serde_json@1.0.81
	slab@0.4.6
	strsim@0.10.0
	syn@1.0.93
	termcolor@1.1.3
	termtree@0.2.4
	textwrap@0.15.0
	unicode-width@0.1.9
	unicode-xid@0.2.3
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.3.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
"

inherit cargo shell-completion

DESCRIPTION="Modern alternative to the tree command"
HOMEPAGE="https://github.com/dduan/tre"
SRC_URI="
	https://github.com/dduan/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_test() {
	cargo_src_test -- --test-threads=1
}

src_install() {
	cargo_src_install

	doman manual/tre.1
	newbashcomp scripts/completion/tre.bash tre
	dofishcomp scripts/completion/tre.fish
	dozshcomp scripts/completion/_tre

	einstalldocs
}
