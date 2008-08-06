# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Fun Input Toy for Linux"
HOMEPAGE="http://code.google.com/p/fitx"

ESVN_REPO_URI="http://fitx.googlecode.com/svn/trunk"
ESVN_PROJECT="fitx"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-i18n/scim
	app-i18n/scim-python
	gnustep-base/gnustep-make
	gnustep-base/gnustep-base
	dev-db/sqlite
	virtual/libiconv
	"
RDEPEND=""

src_unpack() {
	einfo "Unpacking packages"
	subversion_src_unpack
}

src_compile() {
	#hould the build use multiprocessing? Not enabled by default, as it tends to break
	#export JOBS="1"
	#if [[ "${WANT_MP}" == "true" ]]; then
	#	export JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	#fi
	export MAKEOPTS="-j1"

	einfo "Compiling packages"
	. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
	emake || die "Make fail"
}

src_install() {
	einfo "Install fitx"
	emake DESTDIR="${D}" install
}
