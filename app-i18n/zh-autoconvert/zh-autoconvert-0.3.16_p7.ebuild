# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib eutils

MY_PV="${PV/_p/-}"

DESCRIPTION="Chinese HZ/GB/BIG5/UNI/UTF7/UTF8 encodings auto-converter"
HOMEPAGE="https://packages.debian.org/stable/source/zh-autoconvert"
SRC_URI="https://salsa.debian.org/chinese-team/zh-autoconvert/-/archive/debian/${MY_PV}/zh-autoconvert-debian-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-debian-${MY_PV}"

PATCHES=(
"${S}/debian/patches/001-build-static-library.patch"
"${S}/debian/patches/002-chdir-before-symlink.patch"
"${S}/debian/patches/003-strip-binaries.patch"
"${S}/debian/patches/004-delete-empty-default-label-for-gcc-3.4.patch"
"${S}/debian/patches/005-move-plugins-to-usr-lib.patch"
"${S}/debian/patches/006-add-exit.patch"
"${S}/debian/patches/007-migrate-xchat-plugins-to-gtk2.patch"
"${S}/debian/patches/008-add-missing-includes.patch"
"${S}/debian/patches/009-add-placeholder-README-for-lib.patch"
"${S}/debian/patches/010-create-destination-directories-in-Makefile.patch"
"${S}/debian/patches/011-do-not-strip-binaries.patch"
"${S}/debian/patches/012-hardening.patch"
"${S}/debian/patches/013-fix-xchat-plugin-compile-warnings.patch"
"${S}/debian/patches/014-convert-comments-to-utf8.patch"
"${S}/debian/patches/015-convert-docs-to-utf8.patch"
"${S}/debian/patches/016-not-compile-xchat-plugin.patch"
)

src_prepare() {
	default

	# don't build xchat-plugins
	# so don't depend on gtk+-1.2 anymore
	sed -i -e 's/[ ]*xchat-plugins$//' Makefile
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dobin autogb
	dosym autogb /usr/bin/autob5

	if use static-libs; then
		dolib.a lib/libhz.a
	fi

	dolib.so lib/libhz.so.0.0

	dosym libhz.so.0.0 /usr/$(get_libdir)/libhz.so.0
	dosym libhz.so.0 /usr/$(get_libdir)/libhz.so

	insinto /usr/include
	doins include/*.h
}
