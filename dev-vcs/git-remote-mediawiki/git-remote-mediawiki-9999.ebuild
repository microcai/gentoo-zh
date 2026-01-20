# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 perl-functions

DESCRIPTION="Gate between Git and Mediawiki: pull and push Wikipedia articles"

HOMEPAGE="https://github.com/Git-Mediawiki/Git-Mediawiki"

EGIT_REPO_URI="https://github.com/Git-Mediawiki/Git-Mediawiki"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-vcs/git
	dev-perl/MediaWiki-API
	dev-perl/DateTime-Format-ISO8601
	dev-perl/LWP-Protocol-https
"

src_prepare() {
	default
	sed -i -e 's:/lib/git-core:/libexec/git-core:' Makefile || die
}

src_compile() { :; }

src_install() {
	dodir /usr/libexec/git-core
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
		INSTLIBDIR="$(perl_get_vendorlib)" install
}

pkg_postinst() {
	einfo "Clone Wikipedia article with"
	einfo "git clone -c remote.origin.pages='History_of_Belarus' mediawiki::https://en.wikipedia.org/w/ enwiki"
	einfo "the enwiki is a folder name and can be any"
	einfo "and"
	einfo "git config remote.origin.mwLogin 'myUsername'"
	einfo "git config remote.origin.mwPassword 'myPassword'"
	einfo "if you want to push your changes"
}
