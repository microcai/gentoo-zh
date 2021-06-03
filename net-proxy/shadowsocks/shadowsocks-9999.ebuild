# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit eutils distutils-r1 git-r3

DESCRIPTION=" A fast tunnel proxy that helps you bypass firewalls"
HOMEPAGE="http://shadowsocks.org/"

EGIT_REPO_URI="https://github.com/shadowsocks/shadowsocks.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
