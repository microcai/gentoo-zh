# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

PATCHELF_PN=patchelf
PATCHELF_PV=0.18.0
PATCHELF_P="${PATCHELF_PN}-${PATCHELF_PV}"

DESCRIPTION="patchelf patched for building libLoL only"
HOMEPAGE="https://github.com/NixOS/patchelf https://liblol.aosc.io"
SRC_URI="https://github.com/NixOS/${PATCHELF_PN}/archive/${PATCHELF_PV}.tar.gz -> ${PATCHELF_P}.tar.gz"
S="${WORKDIR}/${PATCHELF_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~s390 ~x86 ~amd64-linux ~riscv-linux ~x86-linux"

PATCHES=(
	# "${FILESDIR}"/${PATCHELF_PN}-glibc-dt-mips-xhash.patch  # conflicts with liblol
	"${FILESDIR}"/${PATCHELF_PN}-0.18.0-alpha.patch
	"${FILESDIR}"/${PATCHELF_P}-liblol-${PV}.patch
)

src_prepare() {
	# rm src/elf.h || die
	default

	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--program-suffix=-liblol
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	# prevent collision with the vanilla patchelf
	rm -rf "${D}/usr/share/zsh"
}
