# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools
DESCRIPTION="jzmq"
HOMEPAGE="http://www.zeromq.org/bindings:java"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/zeromq/jzmq.git"
	vcs=git-r3
else
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/zeromq
	>=virtual/jre-1.7:*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}-jni"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	PATH=/etc/java-config-2/current-system-vm/bin:$PATH
	PKG_CONFIG=/usr/lib64/pkgconfig/
	eautomake
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
