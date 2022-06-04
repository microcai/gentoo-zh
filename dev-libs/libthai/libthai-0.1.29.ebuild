# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A a set of Thai language support routines"
HOMEPAGE="https://github.com/tlwg/libthai"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tlwg/${PN}.git"
else
	SRC_URI="https://github.com/tlwg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="dev-libs/libdatrie"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git"

src_prepare() {
	default
	# Fixed version if in non git project
	echo ${PV} > VERSION
	# From upstreams autogen.sh, to make it utilize the autotools eclass
	# Here translate the autogen.sh, equivalent to the following code
	# > sh autogen.sh
	# Fix html doc path
	sed -i -e "s|share/doc/libthai/html|share/doc/libthai-${PV}/html|g" configure.ac || die
	_elibtoolize --force
	eaclocal
	eautomake --add-missing
	# Not allow git-version-gen does refresh
	eautoconf
}
