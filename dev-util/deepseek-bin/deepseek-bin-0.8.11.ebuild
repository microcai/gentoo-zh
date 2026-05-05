# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Coding agent for DeepSeek models with terminal TUI"
HOMEPAGE="https://github.com/Hmbown/DeepSeek-TUI"
SRC_URI="
	amd64? (
		https://github.com/Hmbown/DeepSeek-TUI/releases/download/v${PV}/deepseek-linux-x64
			-> deepseek-${PV}-amd64
		https://github.com/Hmbown/DeepSeek-TUI/releases/download/v${PV}/deepseek-tui-linux-x64
			-> deepseek-tui-${PV}-amd64
	)
	arm64? (
		https://github.com/Hmbown/DeepSeek-TUI/releases/download/v${PV}/deepseek-linux-arm64
			-> deepseek-${PV}-arm64
		https://github.com/Hmbown/DeepSeek-TUI/releases/download/v${PV}/deepseek-tui-linux-arm64
			-> deepseek-tui-${PV}-arm64
	)
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="strip"

src_prepare() {
	default

	case ${ARCH} in
		amd64)
			cp "${DISTDIR}/deepseek-${PV}-amd64" deepseek || die
			cp "${DISTDIR}/deepseek-tui-${PV}-amd64" deepseek-tui || die
			;;
		arm64)
			cp "${DISTDIR}/deepseek-${PV}-arm64" deepseek || die
			cp "${DISTDIR}/deepseek-tui-${PV}-arm64" deepseek-tui || die
			;;
		*)
			die "Unsupported arch ${ARCH}"
			;;
	esac
}

src_install() {
	exeinto /usr/bin
	doexe deepseek deepseek-tui
}
