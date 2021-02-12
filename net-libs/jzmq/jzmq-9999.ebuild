# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="jzmq"
HOMEPAGE="http://www.zeromq.org/bindings:java"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/zeromq/jzmq.git"
	vcs=git-r3
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="net-libs/zeromq"

src_prepare() {
	eaclocal
	eautoconf
}

src_configure() {
	echo "configure"
	PATH=/etc/java-config-2/current-system-vm/bin:$PATH
	PKG_CONFIG=/usr/lib64/pkgconfig/
	eautomake
	econf
	make
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
