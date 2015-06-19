# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_OPTIONAL=1
GENTOO_DEPEND_ON_PERL="no"

inherit autotools eutils distutils-r1 perl-module

DESCRIPTION="Lightweight, language-independent software stack with associated code generation mechanism for RPC"
HOMEPAGE="http://thrift.apache.org"
SRC_URI="mirror://apache/${PN}/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cpp +glib event perl +python qt4 static-libs test +zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="cpp? ( dev-libs/boost:= )
	event? ( dev-libs/libevent )
	glib? ( dev-libs/glib:2 )
	perl? ( dev-lang/perl:= dev-perl/Bit-Vector )
	qt4? ( dev-qt/qtcore:4 )
	zlib? ( sys-libs/zlib )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PV}-autoconf-fixes.patch"

	# fixed in 1.0-dev
	sed -i -e 's|tutorial||' Makefile.am || die

	AT_NO_RECURSIVE=1 eautoreconf

	if use python ; then
		cd "${S}/lib/py"
		distutils-r1_src_prepare
	fi
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable test) \
		$(use_with cpp) \
		$(use_with cpp boost) \
		$(use_with event libevent) \
		$(use_with glib c_glib) \
		$(use_with qt4 qt) \
		$(use_with zlib) \
		--without-{python,perl} \
		--without-{csharp,java,erlang,php,php_extension,ruby,haskell,go,d,nodejs}

	if use perl ; then
		cd "${S}/lib/perl"
		perl-module_src_configure
	fi

	if use python ; then
		cd "${S}/lib/py"
		distutils-r1_src_configure
	fi
}

src_compile() {
	default

	if use perl ; then
		cd "${S}/lib/perl"
		perl-module_src_compile
	fi

	if use python ; then
		cd "${S}/lib/py"
		distutils-r1_src_compile
	fi
}

src_install() {
	default
	prune_libtool_files

	if use perl ; then
		cd "${S}/lib/perl"
		perl-module_src_install
	fi

	if use python ; then
		cd "${S}/lib/py"
		distutils-r1_src_install
	fi
}
