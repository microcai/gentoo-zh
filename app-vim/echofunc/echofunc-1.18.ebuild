# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: Echo the function declaration in the command line for C/C++."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1735"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/${P}.tar.bz2"

LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
RESTRICT="mirror"

VIM_PLUGIN_HELPTEXT=\
"When you type '(' after a function name in insert mode, the function
declaration will be displayed in the command line automatically. Then you may
use Alt+- and Alt+= (configurable via EchoFuncKeyPrev and EchoFuncKeyNext) to
cycle between function declarations (if exists).

Another feature is to provide a balloon tip when the mouse cursor hovers a
function name, macro name, etc. This works with when +balloon_eval is compiled
in.

Use the command below to create tags file including the language and signature
fields.  ctags -R --fields=+lS."
