# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Vim-fork focused on extensibility and agility"
HOMEPAGE="https://neovim.io"
if [[ ${PV} == 9999 ]]; then
	PROPERTIES+=" live"
else
	SRC_URI="
		amd64? ( https://github.com/neovim/neovim/releases/download/v${PV}/nvim-linux-x86_64.tar.gz -> ${P}-amd64.tar.gz )
		arm64? ( https://github.com/neovim/neovim/releases/download/v${PV}/nvim-linux-arm64.tar.gz -> ${P}-arm64.tar.gz )
	"
	KEYWORDS="-* ~amd64"
fi
S="${WORKDIR}"

LICENSE="Apache-2.0 vim"
SLOT="0"
IUSE="+nvimpager"

[[ ${PV} == *9999* ]] && BDEPEND+=" net-misc/curl"
RDEPEND="
	!app-editors/neovim
	app-eselect/eselect-vi
"

RESTRICT="strip"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		local arch_url
		case ${ARCH} in
			amd64) arch_url="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz" ;;
			arm64) arch_url="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-arm64.tar.gz" ;;
			*) die "Unsupported architecture: ${ARCH}" ;;
		esac

		einfo "Downloading neovim nightly for ${ARCH}..."
		curl -L -o "${WORKDIR}/nvim-nightly-${ARCH}.tar.gz" "${arch_url}" || die "Failed to download"
		cd "${WORKDIR}" || die
		tar -xzf "nvim-nightly-${ARCH}.tar.gz" || die "Failed to extract"
	else
		default_src_unpack
	fi
}

src_prepare() {
	default
	mv nvim-linux-*/* . && rm -r nvim-linux-* || die
}

src_install() {
	dobin bin/nvim

	# install a default configuration file
	insinto /etc/vim
	doins "${FILESDIR}"/sysinit.vim

	insinto /usr/lib
	doins -r lib/*
	insinto /usr/share/nvim/runtime
	doins -r share/nvim/runtime/*

	for parser in c lua markdown query vim vimdoc; do
	        dosym ../../../../lib/nvim/parser/${parser}.so /usr/share/nvim/runtime/parser/${parser}.so
	done

	# conditionally install a symlink for nvimpager
	if use nvimpager; then
		fperms a+x usr/share/nvim/runtime/scripts/less.sh
		dosym ../share/nvim/runtime/scripts/less.sh /usr/bin/nvimpager
	fi

	doicon -s 128 share/icons/hicolor/128x128/apps/nvim.png
	domenu share/applications/nvim.desktop
	doman share/man/man1/nvim.1
}

pkg_postinst() {
	xdg_pkg_postinst
	eselect vi update --if-unset

	optfeature "clipboard support" x11-misc/xsel x11-misc/xclip gui-apps/wl-clipboard
	optfeature "Python plugin support" dev-python/pynvim
	optfeature "Ruby plugin support" dev-ruby/neovim-ruby-client
	optfeature "remote/nvr support" dev-python/neovim-remote
}

pkg_postrm() {
	eselect vi update --if-unset
}
