# Copyright 2011 microcai
# Distributed under the terms of the GNU General Public License v2


# @ECLASS: googlecode.eclass
# @MAINTAINER: microcai
# microcaicai@gentoo.org
# @BLURB: 
# @DESCRIPTION:
# Exports portage base functions used by ebuilds written for packages hosting on google code.

inherit eutils autotools

if [ "$HOMEPAGE" = "" ]; then
HOMEPAGE="http://${PN}.googlecode.com"
fi

if [ "${PV##*.}" = "9999" ]; then
	inherit subversion
ESVN_REPO_URI="${HOMEPAGE}/svn/trunk/"
else
	if [ "${TAR_SUFFIX}" = "" ] ; then
		SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
	else
	SRC_URI="http://${PN}.googlecode.com/files/${P}.${TAR_SUFFIX}"
	fi
fi

case "${EAPI:-0}" in
	4|5)
		EXPORT_FUNCTIONS src_install
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

googlecode_src_install(){
	emake install DESTDIR=${D} || die
}

