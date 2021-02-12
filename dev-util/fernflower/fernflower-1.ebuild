# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator


DESCRIPTION="Fernflower is the first actually working analytical decompiler for Java and probably for a high-level programming language in general"
HOMEPAGE="https://github.com/fesh0r/fernflower"
SRC_URI="http://the.bytecode.club/fernflower.jar -> ${P}.jar "

SLOT="0"
RDEPEND=">=virtual/jdk-1.6"
RESTRICT="strip"
IUSE=""
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}"

src_unpack() {
    cp -L ${DISTDIR}/${A} ${S}/${PN}.jar || die
}

src_install() {
    local dir="/opt/${PN}"
    insinto "${dir}"

    doins ${PN}.jar
    make_wrapper "${PN}" "java -jar ${dir}/${PN}.jar" ${dir}
}
