# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit git-r3 vim-plugin

DESCRIPTION="vim plugin: The ultimate vim statusline utility."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3881"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Lokaltog/vim-powerline.git"
EGIT_BRANCH=develop
LICENSE="CCPL-Attribution-ShareAlike-3.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="Powerline"

src_prepare() {
	rm -r .git*
}
