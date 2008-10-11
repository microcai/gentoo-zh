# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.csie.net/"
SRC_URI="http://ucimf.csie.net/file/ucimf-1.9.9.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="iiimf openvanilla dummy"
DEPEND="iiimf? ( app-i18n/libiiimcf ) 
		openvanilla? ( app-i18n/openvanilla-framework )"
RDEPEND="iiimf? ( app-i18n/iiimsf )"

src_compile() {
	cd "work/ucimf-1.9.9/"
	econf || die "econf failed"
	emake || die "emake failed"

#	if use dummy; then
#		econf --includedir=${S}/ucimf/trunk/include  || die "econf failed"
#		emake || die "emake failed"
#	fi	
#
#	if use iiimf; then
#		econf --includedir=${S}/ucimf/trunk/include  || die "econf failed"
#		emake || die "emake failed"
#	fi
#
#	if use openvanilla; then
#		econf --includedir=${S}/ucimf/trunk/include  || die "econf failed"
#		emake || die "emake failed"
#	fi	

}

src_install() {
	# you must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# this is the preferred way to install.
	cd "${WORKDIR}/ucimf-1.9.9"
	emake DESTDIR="${D}" install || die "emake install failed"

#	if use dummy; then
#		cd ${S}/imf/dummy/
#		emake DESTDIR="${D}" install || die "emake install failed"
#	fi	
#
#	if use iiimf; then
#		cd ${S}/imf/iiimf/
#		emake DESTDIR="${D}" install || die "emake install failed"
#	fi
#
#	if use openvanilla; then
#		cd ${S}/imf/openvanilla/
#		emake DESTDIR="${D}" install || die "emake install failed"
#	fi	
	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die "emake install failed"
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die "einstall failed"
}
