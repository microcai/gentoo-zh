# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.8.5-r1.ebuild,v 1.2 2011/11/26 04:49:25 dirtyepic Exp $

EAPI="3"
inherit eutils toolchain-funcs multilib python versionator pax-utils

MY_PN="js"
TARBALL_PV="$(replace_all_version_separators '' $(get_version_component_range 1-3))"
MY_P="${MY_PN}-${PV}"
TARBALL_P="${MY_PN}${TARBALL_PV}-1.0.0"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="https://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/${PV}/source/xulrunner-${PV}.source.tar.bz2"

LICENSE="NPL-1.1"
SLOT="0"

KEYWORDS=""

IUSE="debug static-libs test"

S="${WORKDIR}/mozilla-release"
BUILDDIR="${S}/js/src"

RDEPEND=">=dev-libs/nspr-4.7.0"
DEPEND="${RDEPEND}
	app-arch/zip
	=dev-lang/python-2*[threads]
	dev-util/pkgconfig"

pkg_setup(){
	python_set_active_version 2

	export LC_ALL="C"
}

src_prepare() {
	# https://bugzilla.mozilla.org/show_bug.cgi?id=628723#c43
#	epatch "${FILESDIR}/${P}-fix-install-symlinks.patch"
	# https://bugzilla.mozilla.org/show_bug.cgi?id=638056#c9
#	epatch "${FILESDIR}/${P}-fix-ppc64.patch"
	epatch_user

	if [[ ${CHOST} == *-freebsd* ]]; then
		# Don't try to be smart, this does not work in cross-compile anyway
		ln -sfn "${BUILDDIR}/config/Linux_All.mk" "${S}/config/$(uname -s)$(uname -r).mk"
	fi
}

src_configure() {
	cd "${BUILDDIR}"

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="$(PYTHON)" \
	econf \
		${myopts} \
		--enable-jemalloc \
		--enable-readline \
		--enable-threadsafe \
		--with-system-nspr \
		$(use_enable debug) \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

src_compile() {
	cd "${BUILDDIR}"
	emake || die
}

src_test() {
	cd "${BUILDDIR}/jsapi-tests"
	emake check || die
}

src_install() {
	# genarate mozilla-js.pc
	dodir /usr/$(get_libdir)/pkgconfig
	cat << EOF > ${D}/usr/$(get_libdir)/pkgconfig/mozilla-js.pc
prefix=/usr
libdir=/usr/$(get_libdir)
includedir=/usr/include

Name: SpiderMonkey ${PV}
Description: The Mozilla library for JavaScript ${PV}
Version: ${PV}
Requires: nspr >= 4.7
Libs: -L\${libdir} -lmozjs
Cflags: -I\${includedir}/js
EOF

	cd "${BUILDDIR}"
	emake DESTDIR="${D}" install || die

	# install more
	dodir /usr/include/js/mozilla
	dodir /usr/include/js/vm

	pushd dist/include/mozilla
		cp *  ${D}/usr/include/js/mozilla/
	popd
	pushd dist/include/vm
		cp *  ${D}/usr/include/js/vm/
	popd

	dobin shell/js ||die
	pax-mark m "${ED}/usr/bin/js"

	if ! use static-libs; then
		# We can't actually disable building of static libraries
		# They're used by the tests and in a few other places
		find "${D}" -iname '*.a' -delete || die
	fi
}
