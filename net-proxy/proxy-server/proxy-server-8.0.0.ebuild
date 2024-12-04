# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Implementation of all proxy protocols using modern c++"
HOMEPAGE="https://github.com/jackarain/proxy"
SRC_URI="https://github.com/Jackarain/proxy/archive/refs/tags/v${PV}.tar.gz -> proxy-${PV}.tar.gz"
S="${WORKDIR}/proxy-${PV}"

LICENSE="Boost-1.0"
SLOT="0"
