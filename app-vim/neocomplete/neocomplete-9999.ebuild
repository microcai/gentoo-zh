# Distributed under the terms of the GNU General Public License v2

EAPI=4

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin git-2

DESCRIPTION="vim plugin: Next generation completion framework after neocomplcache"
HOMEPAGE="https://github.com/Shougo/neocomplete.vim"
SRC_URI=""

#EGIT_REPO_URI="https://github.com/Shougo/neocomplete.vim.git"
EGIT_REPO_URI="git@github.com:Shougo/neocomplete.vim.git"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
>app-editors/vim-7.3.885[lua]
>app-editors/gvim-7.3.885[lua] )
!app-vim/neocomplcache"

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

