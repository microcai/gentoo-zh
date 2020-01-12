# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python3_3 python3_4 python3_5 python3_6 )

inherit eutils distutils-r1 git-r3

DESCRIPTION="A video downloader for YouTube, Youku, niconico and a few other sites"
HOMEPAGE="http://www.soimort.org/you-get"

EGIT_REPO_URI="https://github.com/soimort/you-get.git"
EGIT_BRANCH="develop"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
