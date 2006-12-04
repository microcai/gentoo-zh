# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

inherit linux-info toolchain-funcs eutils

DESCRIPTION="Drivers for Realtek 8168 8169 8101 8111 based PCI-E/PCI Ethernet Cards"
HOMEPAGE="http://www.realtek.com.tw/"
MY_PV="v${PV}"
MY_P="${PN}_${MY_PV}"
SRC_URI="ftp://61.56.86.122/cn/nic/${MY_P}.tgz
	ftp://210.51.181.211/cn/nic/${MY_P}.tgz
	ftp://152.104.238.194/cn/nic/${MY_P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"

IUSE=""
DEPEND="sys-kernel/linux-headers"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	export ARCH="$(tc-arch-kernel)"
	emake KSRC="${KERNEL_DIR}" modules || die "make failed"
}

src_install() {

	if kernel_is 2 6; then
		einfo "Kernel ${KV_FULL} detected!"
		insinto "/lib/modules/${KV_FULL}/kernel/drivers/net"
		doins src/r1000.ko
		echo "post-install r1000 /sbin/modprobe --force r1000 >& /dev/null 2>&1 || :" > r1000
	else
		eerror "No supported kernel version (2.6) detected."
	fi

	insinto /etc/modules.d

}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		/sbin/modules-update
		depmod -a
	fi
	einfo "If you have problems loading the module, please check the \"dmesg\" output."
}
