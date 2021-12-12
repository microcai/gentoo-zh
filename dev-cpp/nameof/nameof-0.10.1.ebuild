# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nameof operator for modern C++"
HOMEPAGE="https://github.com/Neargye/nameof"
SRC_URI="
	https://github.com/Neargye/nameof/releases/download/v${PV}/nameof.hpp -> nameof-${PV}.hpp
	doc? ( https://raw.githubusercontent.com/Neargye/nameof/v${PV}/doc/limitations.md -> nameof-${PV}-limitations.md
	https://raw.githubusercontent.com/Neargye/nameof/v${PV}/doc/reference.md -> nameof-${PV}-reference.md )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
RESTRICT="mirror"

src_unpack() {
	cp "${DISTDIR}/nameof-${PV}.hpp" "${WORKDIR}/nameof.hpp" || die
	if use doc
	then
		cp "${DISTDIR}/nameof-${PV}-limitations.md" "${WORKDIR}/limitations.md" || die
		cp "${DISTDIR}/nameof-${PV}-reference.md" "${WORKDIR}/reference.md" || die
	fi
	S="${WORKDIR}"
}

src_install() {
	doheader nameof.hpp
	if use doc
	then
		dodoc limitations.md reference.md
	fi
}
