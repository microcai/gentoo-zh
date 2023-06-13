# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CLOJURE_TOOLS_VER=1.11.1.1347

DESCRIPTION="Clojure command line tools (bin)"
HOMEPAGE="https://clojure.org/"
SRC_URI="https://download.clojure.org/install/clojure-tools-${CLOJURE_TOOLS_VER}.tar.gz"

LICENSE="EPL-1.0"

SLOT="$(ver_cut 1-2)"

KEYWORDS="amd64 x86"

DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}"/clojure-tools

src_prepare() {
	default
	local bin_dir="/usr/bin"
	local clojure_lib_dir="/usr/share/${P}"
	sed -i -e 's@PREFIX@'"$clojure_lib_dir"'@g' clojure || die "Couldn't replace PREFIX in clojure"
	sed -i -e 's@BINDIR@'"$bin_dir"'@g' clj || die "Couldn't replace BINDIR in clj"
}

src_install() {
	insinto /usr/share/${P}
	doins *.edn
	insinto /usr/share/${P}/libexec
	doins *.jar
	newbin clojure clojure-${PV}
	newbin clj clj-${PV}
	doman clojure.1
	doman clj.1
}
