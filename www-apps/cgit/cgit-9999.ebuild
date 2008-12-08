# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://hjemli.net/pub/git/cgit"
WANT_GIT="git-1.6.0.3"

inherit git webapp

DESCRIPTION="a fast web-interface for git repositories"
HOMEPAGE="http://hjemli.net/git/cgit/about/"
SRC_URI="mirror://kernel/software/scm/git/${WANT_GIT}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="test"

RDEPEND="sys-libs/zlib
	dev-libs/openssl"
DEPEND="${RDEPEND}
	test? ( app-text/htmltidy )"

#S=${WORKDIR}

src_unpack() {
	git_src_unpack
	unpack ${A}

	cd "${S}"
	rmdir git && mv "${WANT_GIT}" git
	sed -i \
		-e 's:\(/etc/\)\(\(cgit\)rc\):\1\3/\2:' \
		Makefile
}

src_test() {
	MAKEOPTS="${MAKEOPTS} -j1" emake test || die "test failed"
}

src_install() {
	webapp_src_preinst

	insinto ${MY_HTDOCSDIR}
	newins cgit cgit.cgi || die "newins failed"
	doins cgit.css cgit.png || die "doins failed"
#	newman cgitrc.5.txt cgitrc.5 || die "doman failed"

	insinto /etc/cgit
	doins "${FILESDIR}"/cgitrc.example || die "doins failed"

	dodir /var/cache/cgit
	keepdir /var/cache/cgit

	#FIXME: how to do it correctly?
	fperms +x "${MY_HTDOCSDIR}"/*.cgi || die "fperms failed"

	newdoc cgitrc.5.txt cgitrc.txt || die "newdoc failed"

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
