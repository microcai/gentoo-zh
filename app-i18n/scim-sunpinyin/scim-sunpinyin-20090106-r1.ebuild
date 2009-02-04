# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils

MY_P="inputmethod-repo-snapshot-${PV}"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://www.opensolaris.org/os/project/input-method"
SRC_URI="${HOMEPAGE}/files/${MY_P}.tar.bz2
	http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/lm_sc.t3g.le
	http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/pydict_sc.bin.le"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

# FIXME:
RDEPEND=">=app-i18n/scim-1.4
	sys-libs/glibc
	virtual/libintl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${MY_P}/sunpinyin/ime

src_unpack() {
	unpack ${A} && cd "${S}"

	einfo "Running glib-gettextize -c -f..."
	$(type -p glib-gettextize) -c -f > /dev/null  || die "glib-gettexize failed"
	sed -i \
		-e 's/^DISTFILES = ChangeLog /DISTFILES = /' \
		po/Makefile.in.in || die "sed failed"
	eautoreconf

	cp "${DISTDIR}"/{pydict_sc.bin,lm_sc.t3g}.le data
	epatch "${FILESDIR}"/ic_history.h.diff
}

src_compile() {
	econf \
		$(use_enable debug) \
		--enable-scim \
		--disable-cle
	emake || die "Make faild"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
