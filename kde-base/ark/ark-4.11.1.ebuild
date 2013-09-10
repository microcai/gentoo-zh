# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-4.11.1.ebuild,v 1.1 2013/09/03 19:04:09 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Archiving tool"
HOMEPAGE="http://www.kde.org/applications/utilities/ark
http://utils.kde.org/projects/ark"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+archive +bzip2 debug lzma"

DEPEND="
	$(add_kdebase_dep libkonq)
	sys-libs/zlib
	archive? ( >=app-arch/libarchive-2.6.1:=[bzip2?,lzma?,zlib] )
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# dbus problem

src_prepare() {
	epatch "${FILESDIR}/${PN}-unrar5.patch"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with lzma LibLZMA)
	)
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! has_version app-arch/rar ; then
		elog "For creating rar archives, install app-arch/rar"
	fi
}
