# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: highlight yanked text in vim"
HOMEPAGE="https://github.com/markonm/hlyank.vim"
SRC_URI="https://github.com/markonm/hlyank.vim/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}.vim-${PV}"
LICENSE="MIT"
KEYWORDS="-* ~amd64"

VIM_PLUGIN_HELPFILES="${PN}.txt"
VIM_PLUGIN_HELPTEXT=\
"This plugin highlights yanked text. Yanked text is highlighted with Visual
group for the duration of 200 ms."
