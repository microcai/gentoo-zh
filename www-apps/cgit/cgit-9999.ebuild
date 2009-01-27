# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://hjemli.net/pub/git/cgit"
WANT_GIT="git-1.6.1"

inherit git webapp

DESCRIPTION="a fast web-interface for git repositories"
HOMEPAGE="http://hjemli.net/git/cgit/about/"
SRC_URI="mirror://kernel/software/scm/git/${WANT_GIT}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	dev-libs/openssl"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	git_src_unpack
	unpack ${A}
	cd "${S}"
	rmdir git && mv ${WANT_GIT} git
	sed -i \
		-e 's:\(/etc/\)\(\(cgit\)rc\):\1\3/\2:' \
		Makefile
}

src_install() {
	webapp_src_preinst

	insinto ${MY_HTDOCSDIR}
	newins cgit cgit.cgi || die "newins failed"
	doins cgit.css cgit.png || die "doins failed"
	dodoc  cgitrc.5.txt README || die "dodoc failed"

	insinto /etc/cgit
	doins "${FILESDIR}"/cgitrc.example || die "doins failed"

	dodir /var/cache/cgit
	keepdir /var/cache/cgit

	# This is just plain wrong, how to do it correctly?
	fperms +x "${MY_HTDOCSDIR}"/*.cgi || die "fperms failed"

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
