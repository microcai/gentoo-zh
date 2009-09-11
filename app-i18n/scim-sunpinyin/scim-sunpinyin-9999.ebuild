# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools mercurial

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://www.opensolaris.org/os/project/input-method"
EHG_PROJECT="${PN##scim-}"
EHG_REPO_URI="ssh://anon@hg.opensolaris.org/hg/nv-g11n/inputmethod"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="x11-libs/gtk+
	>=dev-libs/glib-2
	>=app-i18n/scim-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/inputmethod/sunpinyin/ime

src_prepare() {
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
		--enable-scim \
		--disable-cle
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}
