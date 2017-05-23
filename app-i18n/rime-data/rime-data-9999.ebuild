# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

S=${WORKDIR}/brise
inherit git-2
EGIT_REPO_URI="https://github.com/lotem/brise.git"

DESCRIPTION="Brise, data resource for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="app-i18n/librime"
