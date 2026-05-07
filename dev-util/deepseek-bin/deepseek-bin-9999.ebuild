# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Coding agent for DeepSeek models with terminal TUI"
HOMEPAGE="https://github.com/douglarek/deepseek-tui-nightly"
S="${WORKDIR}"

inherit shell-completion

if [[ ${PV} == 9999 ]]; then
	PROPERTIES+=" live"
	BDEPEND+=" net-misc/curl"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="strip"

src_unpack() {
	if [[ ${PV} != 9999 ]]; then
		default_src_unpack
		return
	fi

	local deepseek_url tui_url

	case ${ARCH} in
		amd64)
			deepseek_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/deepseek-linux-x64"
			tui_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/deepseek-tui-linux-x64"
			;;
		arm64)
			deepseek_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/deepseek-linux-arm64"
			tui_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/deepseek-tui-linux-arm64"
			;;
		*) die "Unsupported architecture: ${ARCH}" ;;
	esac

	einfo "Downloading deepseek nightly for ${ARCH}..."
	curl -L -o "${WORKDIR}/deepseek" "${deepseek_url}" || die "Failed to download deepseek"
	curl -L -o "${WORKDIR}/deepseek-tui" "${tui_url}" || die "Failed to download deepseek-tui"
	chmod +x "${WORKDIR}/deepseek" "${WORKDIR}/deepseek-tui" || die
}

src_install() {
	exeinto /usr/bin
	doexe deepseek deepseek-tui

	# shell completions
	./deepseek completions bash > deepseek.bash || die
	dobashcomp deepseek.bash

	./deepseek completions zsh > _deepseek || die
	dozshcomp _deepseek

	./deepseek completions fish > deepseek.fish || die
	dofishcomp deepseek.fish
}
