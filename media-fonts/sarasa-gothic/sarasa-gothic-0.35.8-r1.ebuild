# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="A CJK programming font based on Iosevka and Source Han Sans."
HOMEPAGE="https://github.com/be5invis/Sarasa-Gothic"
SRC_URI="https://github.com/be5invis/Sarasa-Gothic/releases/download/v${PV}/${PN}-ttf-${PV}.7z"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="classical l10n_zh l10n_ja l10n_ko"

RESTRICT="mirror strip"

DEPEND="
	app-arch/p7zip"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	7z x -o"${S}" "${DISTDIR}/${A}"
}

src_configure() {
	if use classical; then
		sleep 0
	else
		rm *-cl-*.ttf
	fi

	if use l10n_zh; then
		sleep 0
	else
		rm *-c-*.ttf
		rm *-hc-*.ttf
		rm *-tc-*.ttf
	fi

	if use l10n_ja; then
		sleep 0
	else
		rm *-j-*.ttf
	fi

	if use l10n_ko; then
		sleep 0
	else
		rm *-k-*.ttf
	fi
}
