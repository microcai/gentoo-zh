# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_SCM="git"

inherit kde4-base

DESCRIPTION="A plugin for KDevelop 4 that visualizes the information from it's static code analysis in graphs."
HOMEPAGE="https://projects.kde.org/projects/playground/devtools/plugins/kdev-control-flow-graph"
SRC_URI=""

EGIT_REPO_URI="https://anongit.kde.org/kdev-control-flow-graph"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-util/kdevelop-4.5"
RDEPEND="${DEPEND}"
