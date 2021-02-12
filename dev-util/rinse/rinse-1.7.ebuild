# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="RPM based distributions bootstrap scripts"
HOMEPAGE="http://www.xen-tools.org/software/rinse"
SRC_URI="http://www.xen-tools.org/software/rinse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-arch/rpm
	dev-perl/libwww-perl"

src_install() {
	emake PREFIX="${D}" install || die "install failed"
}
