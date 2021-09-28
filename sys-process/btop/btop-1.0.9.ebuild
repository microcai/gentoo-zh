# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Resources monitor. The C++ version of bashtop"

HOMEPAGE="https://github.com/aristocratos/btop"
SRC_URI="https://github.com/aristocratos/btop/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0 "
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND="
	>=sys-devel/gcc-10
"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default
	# btop installs README.md to /usr/share/btop by default
	sed -i 's/^.*cp -p README.md.*$//' Makefile
}

src_compile() {
	# Disable btop optimization flags, since we have our flags in CXXFLAGS
	emake \
		OPTFLAGS=""
}

src_install() {
	emake \
		PREFIX="${EPREFIX}/usr" \
		DESTDIR="${D}" \
		install

	dodoc README.md CHANGELOG.md
}
