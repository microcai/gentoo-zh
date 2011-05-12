# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-6.8.ebuild,v 1.1 2008/07/12 12:21:10 tester Exp $

inherit eutils flag-o-matic

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sourceware.org/insight/"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND="sys-libs/ncurses
	x11-libs/libX11"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-6.6-DESTDIR.patch
	epatch "${FILESDIR}"/${PN}-6.6-burn-paths.patch

	cd "${S}/tk"
	epatch "${FILESDIR}"/tkImgGIF.patch
	epatch "${FILESDIR}"/tk-8.4-lastevent.patch
}

src_compile() {
	append-flags -fno-strict-aliasing # tcl code sucks
	strip-linguas -u bfd/po opcodes/po
	econf \
		--disable-werror \
		$(use_enable nls) \
		--enable-gdbtk \
		--disable-tui \
		--datadir=/usr/share/${PN} \
		|| die
	emake || die
}

src_install() {
	# the tcl-related subdirs are not parallel safe
	emake -j1 DESTDIR="${D}" install || die

	# Don't install docs when building a cross-insight
	if [[ ${CTARGET} == ${CHOST} ]] ; then
		dodoc gdb/gdbtk/{README,TODO}
	fi

	# the gui tcl code does not consider any of the configure
	# options given it ... instead, it requires the path to
	# be /usr/share/redhat/...
	mv "${D}"/usr/share/${PN}/redhat "${D}"/usr/share/ || die

	# scrub all the cruft we dont want
	local x
	cd "${D}"/usr/bin
	for x in * ; do
		[[ ${x} != *insight ]] && rm -f ${x}
	done
	cd "${D}"
	rm -rf usr/{include,man,share/{info,locale,man}}
	rm -rf usr/lib*
}
