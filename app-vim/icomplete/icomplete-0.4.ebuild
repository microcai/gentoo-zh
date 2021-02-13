# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit vim-plugin

DESCRIPTION="vim plugin: an c/c++ auto-completion plugin that supports c#/java partually."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1265 http://icomplete.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="app-editors/vim"
RDEPEND="dev-util/ctags"

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}/${P}
	sed 's/CFLAGS="${CFLAGS} -O2 /CFLAGS="${CFLAGS} /g' configure > configure.new
	cat configure.new > configure
	rm configure.new
}

src_compile() {
	# econf doesn't work, because this pkg use tconf framework.
	./configure --prefix=/usr CTAGS_CMD=exuberant-ctags
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
