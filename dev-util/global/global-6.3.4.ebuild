# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools elisp-common eutils

DESCRIPTION="GNU Global is a tag system to find the locations of a specified object in various sources"
HOMEPAGE="http://www.gnu.org/software/global/global.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="ctags doc emacs vim"

RDEPEND="|| ( dev-libs/libltdl:0 sys-devel/libtool:2 )
	sys-libs/ncurses
	ctags? ( dev-util/ctags )
	emacs? ( virtual/emacs )
	vim? ( || ( app-editors/vim app-editors/gvim ) )"
DEPEND="${DEPEND}
	doc? ( app-text/texi2html sys-apps/texinfo )"

SITEFILE="50gtags-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.2.9-tinfo.patch"
	eautoreconf
}

src_configure() {
	econf "$(use_with emacs lispdir "${SITELISP}/${PN}")" \
		"$(use_with ctags exuberant-ctags "/usr/bin/exuberant-ctags")"
}

src_compile() {
	if use doc; then
		texi2pdf -q -o doc/global.pdf doc/global.texi
		texi2html -o doc/global.html doc/global.texi
	fi

	if use emacs; then
		elisp-compile *.el
	fi

	emake
}

src_install() {
	emake DESTDIR="${D}" install

	if use doc; then
		dohtml doc/global.html
		# doc/global.pdf is generated if tex executable (e.g. /usr/bin/tex) is available.
		[[ -f doc/global.pdf ]] && dodoc doc/global.pdf
	fi

	dodoc AUTHORS FAQ NEWS README THANKS

	insinto /etc
	doins gtags.conf

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins gtags.vim
	fi

	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	prune_libtool_files
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
