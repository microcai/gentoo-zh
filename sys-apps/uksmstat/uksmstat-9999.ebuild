# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit git-2
DESCRIPTION="Small tool to show UKSM statistics."
HOMEPAGE="https://github.com/pfactum/uksmstat"
EGIT_REPO_URI="https://github.com/pfactum/uksmstat.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
src_install() {
	dosbin uksmstat/uksmstat || die "Install failed"
	dodoc README.md || die "Install failed"
}
