# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit googlecode

DESCRIPTION="Simple HTTP Daemon Written in BASH"
SRC_URI="${HOMEPAGE}/files/http"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 arm mips alpha"
IUSE=""

RDEPEND="${DEPEND}
	app-shells/bash
	sys-apps/coreutils
"

