# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 git-2

DESCRIPTION=" A fast tunnel proxy that helps you bypass firewalls"
HOMEPAGE="http://shadowsocks.org/"

EGIT_REPO_URI="https://github.com/shadowsocks/shadowsocks.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
