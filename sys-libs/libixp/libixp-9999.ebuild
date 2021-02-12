# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs mercurial

DESCRIPTION="Standalone client/server 9P library"
HOMEPAGE="http://libs.suckless.org/"
EHG_REPO_URI="http://code.suckless.org/hg/libixp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	mercurial_src_unpack

	sed -i \
		-e "/^ *PREFIX/s|=.*|= /usr|" \
		-e "/^ *ETC/s|=.*|= /etc|" \
		-e "/^ *CFLAGS/s|=|+=|" \
		-e "/^ *LDFLAGS/s|=|+=|" \
		"${S}"/config.mk || die "sed failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
}
