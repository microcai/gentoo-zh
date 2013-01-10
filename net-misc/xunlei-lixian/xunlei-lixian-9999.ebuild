# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.7"

inherit git-2

EGIT_REPO_URI="git://github.com/iambus/xunlei-lixian.git"

DESCRIPTION="Download scripts for xunlei vip users"
HOMEPAGE="https://github.com/iambus/xunlei-lixian"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i -e 's#/usr/bin/env python#/usr/bin/python2#' lixian_{cli,hash,batch}.py || die "sed failed"
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r *.py
	fperms 0755 /usr/share/${PN}/lixian_{cli,hash,batch}.py
	dosym /usr/share/${PN}/lixian_cli.py /usr/bin/xunlei-lixian-cli
	dosym /usr/share/${PN}/lixian_hash.py /usr/bin/xunlei-lixian-hash
	dosym /usr/share/${PN}/lixian_batch.py /usr/bin/xunlei-lixian-batch
}
