# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-info toolchain-funcs

NUM="22508"
DESCRIPTION="Intel IA32 microcode update data"
HOMEPAGE="http://downloadcenter.intel.com/Detail_Desc.aspx?DwnldID=22508"
SRC_URI="http://downloadmirror.intel.com/${NUM}/eng/microcode-${PV}.tgz"

LICENSE="intel-ucode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!sys-apps/microcode-data"

S="${WORKDIR}"

CONFIG_CHECK="~MICROCODE_INTEL"
ERROR_MICROCODE_INTEL="Your kernel needs to support Intel microcode loading. You're suggested to build it as a module as it doesn't require a reboot to reload the microcode, that way."

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/intel-microcode2ucode.c ./ || die
}

src_compile() {
	tc-env_build emake intel-microcode2ucode
	./intel-microcode2ucode microcode.dat || die
}

src_install() {
	insinto /lib/firmware
	doins -r intel-ucode
}

pkg_postinst() {
	elog "To reload the new microcode on your CPU, either remove and reinsert"
	elog "the module (microcode) or just use this command:"
	elog "echo -n 1 > /sys/devices/system/cpu/microcode/reload"
}
