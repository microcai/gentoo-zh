# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zchunk/zchunk.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
else
	SRC_URI="https://github.com/zchunk/zchunk/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~riscv"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="A format designed for highly efficient deltas while maintaining good compression"
HOMEPAGE="https://github.com/zchunk/zchunk"
LICENSE="BSD-2"
SLOT="0"
IUSE="doc +curl +openssl test +zstd"
RESTRICT="!test? ( test )"

DEPEND="
	curl? ( net-misc/curl )
	openssl? ( dev-libs/openssl:0/3 )
	zstd? ( app-arch/zstd )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dcoverity=false
		$(meson_feature curl with-curl)
		$(meson_use doc docs)
		$(meson_feature openssl with-openssl)
		$(meson_feature zstd with-zstd)
		$(meson_use test tests)
	)
	meson_src_configure
}
