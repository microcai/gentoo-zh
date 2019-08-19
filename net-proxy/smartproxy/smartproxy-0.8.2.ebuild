# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="A fast, proxy smart selector"
HOMEPAGE="https://github.com/microcai/smartproxy"

SRC_URI="https://github.com/microcai/smartproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"

RESTRICT="mirror"

