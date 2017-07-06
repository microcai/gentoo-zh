# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Toolset to accelerate the boot process and application startup"
HOMEPAGE="http://e4rat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="dev-lang/perl
	>=dev-libs/boost-1.42[static-libs]
	sys-fs/e2fsprogs
	sys-process/audit"

RDEPEND="sys-fs/e2fsprogs"

CMAKE_BUILD_TYPE=release
PREFIX=/
