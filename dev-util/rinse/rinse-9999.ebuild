# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit mercurial

DESCRIPTION="RPM based distributions bootstrap scripts"
HOMEPAGE="http://www.xen-tools.org/software/rinse"
EHG_REPO_BASE="rinse.repository.steve.org.uk"
EHG_REPO_URI="http://${EHG_REPO_BASE}/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	app-arch/rpm
	dev-perl/libwww-perl"

S=${WORKDIR}/${EHG_REPO_BASE}

src_install() {
	emake PREFIX="${D}" install || die "install failed"
}
