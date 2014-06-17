# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Heimdall is a cross-platform open-source tool suite used to flash
firmware (aka ROMs) onto Samsung Galaxy S devices"
HOMEPAGE="http://www.glassechidna.com.au/products/heimdall/"
SRC_URI="https://github.com/Benjamin-Dobell/Heimdall/tarball/v${PV} ->
${P}.tar.gz"

inherit autotools qt4-r2 vcs-snapshot

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~86"
IUSE="qt"

RESTRICT="mirror"

DEPEND=">=virtual/libusb-1
  qt? ( dev-qt/qtgui:4 )"

RDEPEND="${DEPEND}"

src_prepare(){
	pushd heimdall
	  sed 's/sudo service udev restart/echo 1/g' -i Makefile.in
	popd
	if use qt ; then
	    pushd heimdall-frontend
	      qt4-r2_src_prepare
	    popd
	fi
}

src_configure(){
	pushd libpit && econf
	popd
	pushd heimdall && econf
	popd
	if use qt ; then
	    pushd heimdall-frontend
		sed 's/target.path = \/usr\/local\/bin/target.path = \/usr\/bin/g' -i heimdall-frontend.pro
		qt4-r2_src_configure
	    popd
	fi
}

src_compile(){
	pushd libpit && emake
	popd
	pushd heimdall && emake
	popd
	if use qt ; then
	    pushd heimdall-frontend
		qt4-r2_src_compile
	    popd
	fi
}

src_install(){
	pushd heimdall && emake install DESTDIR="${D}"
	popd
	if use qt ; then
	    pushd heimdall-frontend && 	qt4-r2_src_install
	fi
}
