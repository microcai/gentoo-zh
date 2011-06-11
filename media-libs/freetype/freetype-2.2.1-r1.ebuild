# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-libs/freetype/freetype-2.2.1-r1.ebuild,v 1.1 2007/02/09 04:20:42 scsi Exp $

inherit eutils flag-o-matic libtool

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/${PN}-doc-${PV}.tar.bz2 )"

LICENSE="FTL GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="zlib bindist doc cleartype"

# The RDEPEND below makes sure that if there is a version of moz/ff/tb
# installed, then it will have the freetype-2.1.8+ binary compatibility patch.
# Otherwise updating freetype will cause moz/ff/tb crashes.	 #59849
# 20 Nov 2004 agriffis
DEPEND="zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}
	!<www-client/mozilla-1.7.3-r3
	!<www-client/mozilla-firefox-1.0-r3
	!<mail-client/mozilla-thunderbird-0.9-r3
	!<media-libs/libwmf-0.2.8.2"

src_unpack() {

	unpack ${A}
	cd "${S}"

	# disable BCI when distributing binaries (patent issues)
	use bindist || epatch "${FILESDIR}"/${PN}-2-enable_bci.patch

	epatch "${FILESDIR}/${P}-foobillard.patch"
	#http://aur.archlinux.org/packages/freetype2-cleartype/freetype2-cleartype/freetype-2.2.1-subpixel-disable-quantization.diff
	use cleartype && epatch "${FILESDIR}"/freetype-2.2.1-subpixel-disable-quantization.diff
	elibtoolize
	epunt_cxx

}

src_compile() {
	# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118021
	append-flags "-fno-strict-aliasing"

	type -p gmake &> /dev/null && export GNUMAKE=gmake
	econf $(use_with zlib) || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog README
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PATENTS,TODO}

	cd "${WORKDIR}"/${PN}-doc-${PV}
	use doc && dohtml -r docs/*
}
