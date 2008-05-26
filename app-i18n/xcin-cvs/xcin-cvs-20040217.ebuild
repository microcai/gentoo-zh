# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit cvs eutils

DESCRIPTION="Chinese X Input Method with UTF8 support"
HOMEPAGE="http://xcin.linux.org.tw/"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls unicode"

ECVS_USER="xcin"
ECVS_PASS="xcin"
ECVS_SERVER="xcin.linux.org.tw:/home/service/cvsroot/xcin"
ECVS_MODULE="xcin"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S="${WORKDIR}/${ECVS_MODULE}"

DEPEND="dev-libs/libchewing
	nls? ( sys-devel/gettext )
	>=app-i18n/libtabe-0.2.5
	unicode? ( media-fonts/hkscs-ming )
	!app-i18n/xcin"

src_unpack() {
	cvs_src_unpack

	cd ${S}
	epatch ${FILESDIR}/xcin-chewing.diff

	# gcc3.2 changed the way we deal with -I. So until the configure script
	# is updated we need this hack as a work around.
	#EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/xcin-2.5.3_pre2-gentoo.patch
	#EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/xcin-2.5.3_pre2-db3.patch

	# paar's fix
	#mv ${S}/cin/big5/* ${S}/../cin/big5/
}

src_compile() {
	./autogen.sh

	econf \
		--with-xcin-rcdir=/etc \
		--with-xcin-dir=/usr/lib/X11/xcin25 \
		--with-db-lib=/usr/lib \
		--with-tabe-inc=/usr/include/tabe \
		--with-tabe-lib=/usr/lib  ||  die "./configure failed"

	emake -j1 || die "make failed!"
}

src_install() {
	make \
		prefix=${D}/usr \
		program_prefix=${D} \
		install || die
	dodir /etc

	insinto /etc
	newins ${FILESDIR}/gentoo-xcinrc xcinrc
	insinto /etc/xim-select
	newins ${FILESDIR}/xim-select.xcin xcin

	dodoc doc/*

	for docdir in doc/En doc/En/internal doc/history doc/internal doc/modules; do
		docinto ${docdir#doc/}
		dodoc ${docdir}/*
	done
}
