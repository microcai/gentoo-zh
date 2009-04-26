# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils versionator

MY_P=FoxitReader-$(replace_version_separator 2 '-').i386
SRC_BASE="http://mirrors.foxitsoftware.com/pub/foxit/reader/desktop/linux"

DESCRIPTION="Foxit Reader for desktop Linux"
HOMEPAGE="http://www.foxitsoftware.com/pdf/desklinux"
SRC_URI="${SRC_BASE}/$(get_major_version).x/$(get_version_component_range 1-2)/enu/${MY_P}.tar.bz2"

LICENSE="Foxit-EULA"
SLOT="0"
KEYWORDS="-* ~x86" # TODO: amd64 support
IUSE=""

DEPEND=""
RDEPEND="media-libs/freetype:2
	>=x11-libs/gtk+-2.12"

RESTRICT="mirror strip"

src_install() {
	ebegin "Installing package"
		dodir /opt/${PN}
		mv "${WORKDIR}"/* "${D}"/opt/${PN}
	eend $? || die "failed to install package"

	doicon "${FILESDIR}"/fx-icon.png
	domenu "${FILESDIR}"/foxit-reader.desktop

	make_wrapper foxitreader ./FoxitReader /opt/${PN}
}
