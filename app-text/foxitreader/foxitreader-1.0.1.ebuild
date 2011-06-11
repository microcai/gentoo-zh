# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils versionator

MY_PN="FoxitReader"
MY_P="${MY_PN}-$(replace_version_separator 2 '-').i386"
SRC_BASE="http://mirrors.foxitsoftware.com/pub/foxit/reader/desktop/linux"

DESCRIPTION="Foxit Reader for desktop Linux"
HOMEPAGE="http://www.foxitsoftware.com/pdf/desklinux"
SRC_URI="${SRC_BASE}/$(get_major_version).x/$(get_version_component_range 1-2)/enu/${MY_P}.tar.bz2"

LICENSE="Foxit-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-gtklibs )
	x86? ( media-libs/freetype:2
		>=x11-libs/gtk+-2.12 )"

RESTRICT="mirror strip"

src_install() {
	mv "${WORKDIR}"/{Readme.txt,README}
	dodoc "${WORKDIR}"/README
	rm "${WORKDIR}"/README

	ebegin "Installing package"
		insinto /opt/${PN}
		doins "${WORKDIR}"/* || die "failed to install program files"
		fperms 0755 /opt/${PN}/${MY_PN}
	eend $? || die "failed to install package"

	doicon "${FILESDIR}"/${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop

	make_wrapper ${PN} /opt/${PN}/${MY_PN}
}
