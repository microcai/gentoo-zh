# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

MY_P=${PN}-$(replace_version_separator 3 '_')
DESCRIPTION="OpenVanilla Modules for Generic Tables"
HOMEPAGE="http://openvanilla.org http://ucimf.googlecode.com"
SRC_URI="http://ucimf.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/sqlite-3"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
