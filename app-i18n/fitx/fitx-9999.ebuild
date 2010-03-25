# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python subversion

ESVN_REPO_URI="http://fitx.googlecode.com/svn/trunk"

DESCRIPTION="Fun Input Toy for Linux"
HOMEPAGE="http://code.google.com/p/fitx"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-i18n/ibus
	dev-db/sqlite
	gnustep-base/gnustep-base
	virtual/libiconv"
RDEPEND="${DEPEND}
	gnustep-base/gnustep-make"

src_compile() {
	#hould the build use multiprocessing? Not enabled by default, as it tends to break
	#export JOBS="1"
	#if [[ "${WANT_MP}" == "true" ]]; then
	#	export JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	#fi
	export MAKEOPTS="-j1"

	. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
	emake || die "Make fail"
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -R "${D}"/usr/share/scim-python
}

pkg_postinst() {
	python_mod_optimize /usr/share/ibus-${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/ibus-${PN}
}
