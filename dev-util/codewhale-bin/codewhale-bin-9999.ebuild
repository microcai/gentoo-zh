# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Coding agent with terminal TUI"
HOMEPAGE="https://github.com/Hmbown/CodeWhale"
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

	local codewhale_url tui_url

	case ${ARCH} in
		amd64)
			codewhale_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/codewhale-linux-x64"
			tui_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/codewhale-tui-linux-x64"
			;;
		arm64)
			codewhale_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/codewhale-linux-arm64"
			tui_url="https://github.com/douglarek/deepseek-tui-nightly/releases/download/nightly/codewhale-tui-linux-arm64"
			;;
		*) die "Unsupported architecture: ${ARCH}" ;;
	esac

	einfo "Downloading codewhale nightly for ${ARCH}..."
	curl -L -o "${WORKDIR}/codewhale" "${codewhale_url}" || die "Failed to download codewhale"
	curl -L -o "${WORKDIR}/codewhale-tui" "${tui_url}" || die "Failed to download codewhale-tui"
	chmod +x "${WORKDIR}/codewhale" "${WORKDIR}/codewhale-tui" || die
}

src_install() {
	exeinto /usr/bin
	doexe codewhale codewhale-tui

	# shell completions
	./codewhale completions bash > codewhale.bash || die
	dobashcomp codewhale.bash

	./codewhale completions zsh > _codewhale || die
	dozshcomp _codewhale

	./codewhale completions fish > codewhale.fish || die
	dofishcomp codewhale.fish
}
