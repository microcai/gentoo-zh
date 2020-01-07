# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit bash-completion-r1 eutils distutils-r1 git-2

DESCRIPTION="Console client for Evernote"
HOMEPAGE="http://geeknote.me"

EGIT_REPO_URI="https://github.com/VitaliyRodnenko/geeknote.git"
EGIT_BRANCH="master"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bash-completion"

RDEPEND="
	bash-completion? ( app-shells/bash-completion )
	dev-python/html2text
	dev-python/sqlalchemy
	dev-python/markdown2
	dev-python/beautifulsoup:4
	dev-python/evernote-sdk-python
"

DEPEND="
	${RDEPEND}
"

src_install() {

	if use bash-completion; then
		dobashcomp ${FILESDIR}/geeknote
	fi

	distutils-r1_src_install
}
