# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_SCM="git"

inherit kde4-base

DESCRIPTION="This plugin offers a \"Linux Kernel\" project type to KDevelop that makes it easy and comfortable to work on the Linux kernel."
HOMEPAGE="https://github.com/Gnurou/kdev-kernel"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Gnurou/kdev-kernel.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-util/kdevelop-4.3.90"
RDEPEND="${DEPEND}"
