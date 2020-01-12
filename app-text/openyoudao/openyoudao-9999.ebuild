# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3

DESCRIPTION="openyoudao is a youdao client for linux."
HOMEPAGE="http://openyoudao.org"

EGIT_REPO_URI="https://github.com/justzx2011/openyoudao.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-misc/xclip
    dev-python/pywebkitgtk
    dev-python/python-xlib
    dev-python/lxml
    dev-python/beautifulsoup"

RDEPEND="${DEPEND}"

src_prepare(){
        sed -i '1,5s/BeautifulSoup/bs4/' fusionyoudao.py || die "patch error"
}

src_install(){
        insinto /usr/bin
        dobin ${S}/scripts/openyoudao || die "Install failed"

        insinto /usr/lib/openyoudao
        doins ${S}/*.py || die "lib install failed"

        insinto /usr/share/openyoudao
        doins -r ${S}/cache/* || die "cache install failed"

        insinto /usr/share/applications
        doins ${S}/desktop/openyoudao.desktop || die "desktop link install failed"
}
