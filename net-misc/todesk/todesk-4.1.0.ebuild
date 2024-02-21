# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ToDesk作为一款安全免费不限速的远程控制软件，通过领先的网络技术搭建并运营自己的网络系统，拥有覆盖全球的多节点、多业务，毫秒级延时应用层路由系统，带给用户像使用本地电脑一样的体验感。"
HOMEPAGE="https://www.todesk.com/"
SRC_URI="https://newdl.todesk.com/linux/todesk_4.1.0_x86_64.pkg.tar.zst"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="strip mirror"

S="${WORKDIR}"

src_unpack(){
    pushd "${DISTDIR}"
    tar -xvf ${A} -C "${WORKDIR}"
    popd
}

src_install(){
    insinto /
    doins -r usr/
    doins -r opt/
    doins -r etc/
    fperms 0755 /usr/bin/todesk
    fperms 0755 /opt/todesk/bin/todesk
    fperms 0755 /opt/todesk/bin/todeskc
    fperms 0755 /opt/todesk/bin/todeskd
}
