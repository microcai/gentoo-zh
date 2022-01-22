# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..10} )

inherit git-r3 python-single-r1

DESCRIPTION="an ad-hoc single file webserver"
HOMEPAGE="http://www.home.unix-ag.org/simon/woof.html https://github.com/simon-budig/woof"
EGIT_REPO_URI="https://github.com/simon-budig/${PN}.git"
EGIT_CLONE_TYPE="single"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+gzip +bzip2 +unzip"

DEPEND="
	gzip? ( app-arch/gzip )
	bzip2? ( app-arch/bzip2 )
	unzip? ( app-arch/unzip )
"

RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	python_doscript ${PN}
}
