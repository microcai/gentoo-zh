# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python{2_6,2_7} )

DESCRIPTION="The YubiKey PIV Manager enables you to configure a PIV-enabled YubiKey through a graphical user interface."
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="https://developers.yubico.com/yubikey-piv-manager/Releases/yubikey-piv-manager-${PV}.tar.gz"

inherit distutils-r1

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
DEPEND="dev-python/pyside
        dev-python/pycrypto
        app-crypt/yubico-piv-tool"

PATCHES=(
    # PySide does not distribute egg-info, so remove it from deps
    "${FILESDIR}"/${PN}-fix-pyside-requirement.patch
)

src_install()
{
        distutils-r1_src_install || die
        domenu resources/pivman.desktop || die
        doicon resources/pivman.xpm || die
}
