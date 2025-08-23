# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Vim-fork focused on extensibility and agility"
HOMEPAGE="https://neovim.io"
SRC_URI="https://github.com/neovim/neovim/releases/download/v${PV}/nvim-linux-x86_64.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/nvim-linux-x86_64

LICENSE="Apache-2.0 vim"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+nvimpager"

RDEPEND="
	!app-editors/neovim
	app-eselect/eselect-vi
"

RESTRICT="strip"

src_install() {
	dobin bin/nvim

	# install a default configuration file
	insinto /etc/vim
	doins "${FILESDIR}"/sysinit.vim

	insinto /usr/lib
	doins -r lib/*
	insinto /usr/share/nvim/runtime
	doins -r share/nvim/runtime/*

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

	optfeature "clipboard support" x11-misc/xsel x11-misc/xclip gui-apps/wl-clipboard
	optfeature "Python plugin support" dev-python/pynvim
	optfeature "Ruby plugin support" dev-ruby/neovim-ruby-client
	optfeature "remote/nvr support" dev-python/neovim-remote
}
