# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="The Yubico PIV Tool allows you to configure a PIV-enabled YubiKey through a command line interface."
HOMEPAGE="https://developers.yubico.com/yubico-piv-tool/"
SRC_URI="https://developers.yubico.com/yubico-piv-tool/Releases/yubico-piv-tool-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
DEPEND="sys-apps/pcsc-lite
        dev-libs/openssl"
RDEPEND="${DEPEND}"
