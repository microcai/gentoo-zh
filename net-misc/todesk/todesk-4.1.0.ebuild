# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ToDesk不一样的远控体验，轻松打破物理限制，随时随地高效使用所有计算终端"
HOMEPAGE="https://www.todesk.com/"
SRC_URI="https://newdl.todesk.com/linux/todesk_${PV}_x86_64.pkg.tar.zst"

S="${WORKDIR}"

LICENSE="todesk"

SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip mirror"

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
