# Eclass for Erlang packages
#
# Copyright (c) 2015, wittyfox <slogerdream@gmail.com>
# Copyright (c) 2007, Christopher Covington <covracer@gmail.com>
# Copyright (c) 2007, Gentoo Foundation
#
# Licensed under the GNU General Public License, v2
#
# $Header: Exp $

# -----------------------------------------------------------------------------
# @eclass-begin
# @eclass-summary Eclass for Erlang Packages
#
# This eclass should be inherited for pure Erlang packages.
# -----------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# @depend
#
# Erlang packages only commonly depend on erlang.
# ------------------------------------------------------------------------------
DEPEND=">=dev-lang/erlang-15.2.3"

# ------------------------------------------------------------------------------
# @rdepend
#
# Nothing special for RDEPEND--just the same as DEPEND
# ------------------------------------------------------------------------------
RDEPEND="${DEPEND}"

EXPORT_FUNCTIONS src_compile src_install

# ------------------------------------------------------------------------------
# @eclass_compile-erl
#
# Compile *.erl in ${S}/src and put it in ${S}/ebin optionally including
# a space deliminated list of directories
# ------------------------------------------------------------------------------
erlang-pkg_compile-erl() {
	until [ -z "$1" ] ; do
		INCLUDE="${INCLUDE} -I $1"
		shift
	done
	if [[ ! -e "${S}/ebin" ]] ; then
		mkdir "${S}/ebin"
	fi
	erlc -o "${S}/ebin" ${INCLUDE} "${S}/src/"*.erl \
		|| die "failed to compile .erl source"
}

# ------------------------------------------------------------------------------
# @eclass_compile-et
#
# Compile *.et in ${S}/src and put it in ${S}/ebin
# ------------------------------------------------------------------------------
erlang-pkg_compile-et() {
	if [[ ! -e "${S}/ebin" ]] ; then
		"mkdir ${S}/ebin"
	fi
	erl -noshell \
		$( find "${S}/src" -type f -name "*.et" -exec \
			echo -n "-s erltl compile {} " \; ) \
		-s init stop \
		|| die "failed to compile .et source"
	mv "${S}/src/"*.beam "${S}/ebin" \
		|| die "failed to move .et source"
}

# ------------------------------------------------------------------------------
# @eclass-src_compile
#
# Default src_compile for erlang packages
# ------------------------------------------------------------------------------
erlang-pkg_src_compile() {
	erlang-pkg_compile-erl
}

# ------------------------------------------------------------------------------
# @eclass_dodoc
#
# Copy ${S}/doc into /usr/lib/erlang/lib/${P}/
# ------------------------------------------------------------------------------
erlang-pkg_dodoc() {
	dodir /usr/lib/erlang/lib/${P}
	cp -R "${S}/doc" "${D}usr/lib/erlang/lib/${P}/" \
		|| die "failed to install doc"
}

# ------------------------------------------------------------------------------
# @eclass_doebin
#
# Copy ${S}/ebin into ${D}/usr/lib/erlang/lib/${P}/
# ------------------------------------------------------------------------------
erlang-pkg_doebin() {
	dodir /usr/lib/erlang/lib/${P}
	cp -R "${S}/ebin" "${D}usr/lib/erlang/lib/${P}/" \
		|| die "failed to install binaries"
}

# ------------------------------------------------------------------------------
# @eclass_doinclude
#
# Copy ${S}/include into /usr/lib/erlang/lib/${P}/
# ------------------------------------------------------------------------------
erlang-pkg_doinclude() {
	dodir /usr/lib/erlang/lib/${P}
	cp -R "${S}/include" "${D}usr/lib/erlang/lib/${P}/" \
		|| die "failed to install includes"
}

# ------------------------------------------------------------------------------
# @eclass_dopriv
#
# Copy ${S}/priv into /usr/lib/erlang/lib/${P}/
# ------------------------------------------------------------------------------
erlang-pkg_dopriv() {
	dodir /usr/lib/erlang/lib/${P}
	cp -R "${S}/priv" "${D}usr/lib/erlang/lib/${P}/" \
		|| die "failed to install priv"
}

# ------------------------------------------------------------------------------
# @eclass_dosrc
#
# Copy ${S}/src into /usr/lib/erlang/lib/${P}/
# ------------------------------------------------------------------------------
erlang-pkg_dosrc() {
	dodir /usr/lib/erlang/lib/${P}
	cp -R "${S}/src" "${D}usr/lib/erlang/lib/${P}/" \
		|| die "failed to install source code"
}

# ------------------------------------------------------------------------------
# @eclass-src_install
#
# Default src_install for erlang packages
# ------------------------------------------------------------------------------
erlang-pkg_src_install() {
	erlang-pkg_doebin
}

# ------------------------------------------------------------------------------
# @eclass-end
# ------------------------------------------------------------------------------
