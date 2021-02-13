# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Library of unicode annotation data"
HOMEPAGE="https://github.com/fontforge/libuninameslist"
SRC_URI="https://github.com/fontforge/libuninameslist/releases/download/${PV}/libuninameslist-dist-${PV}.tar.gz"

inherit autotools

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="static-libs"
