# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit autotools

MY_P="${P##scim-}"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://www.opensolaris.org/os/project/input-method"
# le -> little endian data files / be -> big endian datafiles.
SRC_URI="http://oahong.googlepages.com/${MY_P}.tar.bz2
	http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/lm_sc.t3g.le
	http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/pydict_sc.bin.le"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

# FIXME:
RDEPEND="x11-libs/gtk+
	>=dev-libs/glib-2
	>=app-i18n/scim-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${MY_P}/sunpinyin/ime

src_prepare() {
	einfo "Running glib-gettextize -c -f..."
	$(type -p glib-gettextize) -c -f > /dev/null || \
		die "glib-gettexize failed"
	sed -i \
		-e 's/^DISTFILES = ChangeLog /DISTFILES = /' \
		po/Makefile.in.in || die "sed failed"
	eautoreconf

	cp "${DISTDIR}"/{pydict_sc.bin,lm_sc.t3g}.le data || \
		die "failed to copy data files"
}

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-scim \
		--disable-cle
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}
