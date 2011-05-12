# Copyright 2011 microcai
# Distributed under the terms of the GNU General Public License v2


# @ECLASS: googlecode.eclass
# @MAINTAINER: microcai
# microcaicai@gentoo.org
# @BLURB: 
# @DESCRIPTION:
# Exports portage base functions used by ebuilds written for packages hosting on google code.

inherit eutils autotools

case "${EAPI:-0}" in
	3|4)
		EXPORT_FUNCTIONS src_install
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac



HOMEPAGE="http://${PN}.googlecode.com"
ESVN_REPO_URI="${HOMEPAGE}/svn/trunk/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"


googlecode_src_install(){
	emake install DESTDIR=${D} || die
}

