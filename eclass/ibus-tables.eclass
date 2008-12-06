# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: ibus-tables.eclass
# @MAINTAINER:
# Hong Hao <oahong@gmail.com>
# Yu Yuwei <acevery@gmail.com>
# Original Author: Hong Hao <oahong@gmail.com>
# @DESCIPTION:
# Generalize code-table installation for app-i18n/ibus-table.
#

inherit base autotools

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/acevery/${PN}.git"
	EGIT_BRANCH="master"
#	EGIT_OFFLINE="yup"
	inherit git
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="${PN/ibus-table} code-table for ibus-table input engine"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""


RDEPEND=">=app-i18n/ibus-table-0.1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	extra-phrases? ( >=app-i18n/ibus-table-extraphrase-0.1.2 )"

DOCS="AUTHORS README"

ibus-tables_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${PV} == "9999" ]] ; then
		git_src_unpack
		eautoreconf || die "fail to run autoreconf"
	else
		base_src_unpack
	fi
}

ibus-tables_src_compile() {
	debug-print-function ${FUNCNAME} "$@"
	USE_ENABLE=""
	for e in ${IUSE}; do
		e=${e/+/}
		USE_ENABLE="${USE_ENABLE} $(useq ${e} && echo --enable-${e}\
		|| echo --disable-${e})"
	done

	econf \
		${USE_ENABLE}
	emake -j1 || die "emake failed"
}

ibus-tables_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	base_src_install
	ebegin "dodoc" 
		dodoc ${DOCS} 2> /dev/null
	eend $?
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
