# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Secure Socket Tunneling Protocol (SSTP) server implemented in Python."
HOMEPAGE="https://github.com/sorz/sstp-server/"
SRC_URI="https://github.com/sorz/sstp-server/archive/v0.6.0.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64 mips arm"

PYTHON_COMPAT=( python3_{9..12} )

inherit systemd distutils-r1

DEPEND="net-dialup/ppp"

RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
    distutils-r1_src_install

    insinto /etc/
    doins sstp-server.ini

    systemd_dounit ${FILESDIR}/sstp-server@.service
}
