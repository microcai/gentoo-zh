# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools python mercurial

EHG_PROJECT="${PN##ibus-}"
EHG_REPO_URI="ssh://anon@hg.opensolaris.org/hg/nv-g11n/inputmethod"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://www.opensolaris.org/os/project/input-method"
SRC_URI="http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/lm_sc.t3g.le
	http://src.opensolaris.org/source/raw/nv-g11n/inputmethod/sunpinyin/ime/data/pydict_sc.bin.le"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="x11-libs/gtk+
	>=dev-libs/glib-2
	>=app-i18n/ibus-1.0
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/inputmethod/sunpinyin2

src_prepare() {
	cp -r "${FILESDIR}"/data "${S}"
	cp "${DISTDIR}"/{pydict_sc.bin,lm_sc.t3g}.le "${S}"/data
	epatch "${FILESDIR}"/${PN}-icon.patch

	# autogen.sh does more than just run autotools
	sed -i \
		-e 's:^\$LIBTOOLIZE:_elibtoolize:' \
		-e 's:^acl:eacl:' \
		-e 's:^auto:eauto:' \
		 autogen.sh || die "sed failed"
	(. ./autogen.sh) || die "autogen.sh failed"
}

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-ibus \
		--disable-{scim,cle,gtkstandalone} \
		--disable-{bestandalone,becjk-module}
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/ibus-sunpinyin/setup
}

pkg_postrm() {
	python_mod_cleanup /usr/share/ibus-sunpinyin/setup
}
