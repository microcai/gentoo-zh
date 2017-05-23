# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_SCM="git"

inherit kde4-base

DESCRIPTION="KDevelop Plugin for SQL Language Support"
HOMEPAGE="https://projects.kde.org/projects/playground/devtools/plugins/kdev-sql"
SRC_URI=""

EGIT_REPO_URI="https://anongit.kde.org/kdev-sql"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-util/kdevelop-4.5
>=dev-util/kdevplatform-1.5.60"
RDEPEND="${DEPEND}"
