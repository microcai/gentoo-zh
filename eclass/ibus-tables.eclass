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
#	EGIT_OFFLINE="YES_PLEASE" # offline mode for testing. (no update from github)
	inherit git
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="${PN/ibus-table-} code-table for ibus-table input engine"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""


RDEPEND=">=app-i18n/ibus-table-0.1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	extra-phrases? ( >=app-i18n/ibus-table-extraphrase-0.1.2 )"

DOCS=""

ibus-tables_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${PV} == "9999" ]] ; then
		git_src_unpack
		# hmm...eauto{,re}conf/econf dies on itself.
		eautoreconf || die "fail to run autoreconf"
	else
		base_src_unpack
	fi
}

ibus-tables_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	local USE_ENABLE=""
	for e in ${IUSE/+}; do
		USE_ENABLE="${USE_ENABLE} $(useq ${e} && \
			echo --enable-${e} || \
			echo --disable-${e})"
	done

	econf \
		${USE_ENABLE}
	emake -j1 || die "emake failed"
}

ibus-tables_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	base_src_install

	dodoc ${DOCS} 2> /dev/null
}

ibus-tables_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	echo
	ewarn "Please offer your suggestions and/or report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	echo
}

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst
