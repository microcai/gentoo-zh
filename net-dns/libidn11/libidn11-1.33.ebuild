# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VERIFY_SIG_OPENPGP_KEY_PATH=${BROOT}/usr/share/openpgp-keys/libidn.asc
inherit elisp-common libtool multilib-minimal verify-sig

MY_P=libidn-${PV}

RESTRICT="mirror"

DESCRIPTION="Internationalized Domain Names (IDN) implementation"
HOMEPAGE="https://www.gnu.org/software/libidn/"
SRC_URI="mirror://gnu/libidn/${MY_P}.tar.gz
	verify-sig? ( mirror://gnu/libidn/${MY_P}.tar.gz.sig )"

LICENSE="GPL-2 GPL-3 LGPL-3"

SLOT="11"

KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="nls"

S="${WORKDIR}/libidn-1.33"

DOCS=( AUTHORS ChangeLog FAQ NEWS README THANKS )

COMMON_DEPEND="
	nls? ( >=virtual/libintl-0-r1[${MULTILIB_USEDEP}] )
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"
BDEPEND="
	nls? ( >=sys-devel/gettext-0.17 )
	verify-sig? ( app-crypt/openpgp-keys-libidn )
"

src_prepare() {
	default

	# For Solaris shared objects
	elibtoolize
}

multilib_src_configure() {
	local args=(
		$(use_enable nls)
		--disable-java
		--disable-mono
		--disable-csharp
		--disable-static
		--disable-valgrind-tests
		--with-lispdir="${EPREFIX}${SITELISP}/${PN}"
		--with-packager-bug-reports="https://bugs.gentoo.org"
		--with-packager-version="r${PR}"
		--with-packager="Gentoo"
	)

	ECONF_SOURCE="${S}" econf "${args[@]}"
}

multilib_src_test() {
	# Only run libidn specific tests and not gnulib tests (bug #539356)
	emake -C tests check
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name 'libidn.so' -delete || die
	rm -rf ${ED}/usr/include
	rm -rf ${ED}/usr/*/pkgconfig
	rm -rf ${ED}/usr/share
	rm -rf ${ED}/usr/bin
}

