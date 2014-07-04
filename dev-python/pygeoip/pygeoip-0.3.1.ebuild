# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 git-2 vcs-snapshot

DESCRIPTION="A simple library to encode/decode DNS wire-format packets."
HOMEPAGE="https://github.com/appliedsec/pygeoip"
SRC_URI="https://github.com/appliedsec/pygeoip/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
