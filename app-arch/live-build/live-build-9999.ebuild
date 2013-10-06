# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit base git-2

DESCRIPTION="Debian Live - System Build Scripts"
HOMEPAGE="http://live.debian.net/"

EGIT_REPO_URI="git://live.debian.net/git/live-build.git"
EGIT_MASTER="upstream"
EGIT_BRANCH="upstream"
EGIT_COMMIT="upstream"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# probably needs more/less crap listed here ...
RDEPEND=""
DEPEND="${RDEPEND}"
