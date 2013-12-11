# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/json-tools/json-tools-0.3.2.ebuild,v 1.1 2013/10/10 22:23:34 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 git-2

DESCRIPTION="A simple library to encode/decode DNS wire-format packets."
HOMEPAGE="https://bitbucket.org/paulc/dnslib"
EGIT_REPO_URI="git://github.com/paulchakravarti/dnslib.git"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
