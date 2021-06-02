# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN##zsh-theme-}"

DESCRIPTION="Theme for Zsh that emphasizes speed, flexibility and out-of-the-box experience"
HOMEPAGE="https://github.com/romkatv/powerlevel10k"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="app-shells/zsh
        app-shells/gitstatus"
RDEPEND="${DEPEND}"
BDEPEND=""


S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -i Makefile -e '/gitstatus/d'

	default
}

src_compile() {
	emake pkg
}

src_install() {
	dodoc {README,font}.md

	insinto "/usr/share/zsh/site-functions/${MY_PN}"

	doins -r config/
	doins -r internal/
	doins prompt_*_setup
	doins powerlevel*.zsh-theme{,.zwc}

	dosym ../../../gitstatus \
		"/usr/share/zsh/site-functions/${MY_PN}/gitstatus"
}

pkg_postinst() {
	elog "To use this theme source /usr/share/zsh/site-functions/powerlevel10k/powerlevel10k.zsh-theme in your ~/.zshrc"
	elog "The full choice of style options is available only when using Nerd Fonts.For example: media-fonts/nerd-fonts"
}
