# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit unpacker

DESCRIPTION="Binary plugin for HPs hplip printer driver library"
HOMEPAGE="http://hplipopensource.com/hplip-web/index.html"
SRC_URI="http://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-${PV}-plugin.run"

LICENSE="hplip-plugin"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	~net-print/hplip-${PV}
"
DEPEND=""

S=${WORKDIR}

HPLIP_HOME=/usr/share/hplip

# Binary prebuilt package
QA_PRESTRIPPED="
/usr/share/hplip/scan/plugins/bb_marvell.so
/usr/share/hplip/scan/plugins/bb_soapht.so
/usr/share/hplip/scan/plugins/bb_soap.so
/usr/share/hplip/fax/plugins/fax_marvell.so
/usr/share/hplip/prnt/plugins/lj.so"

# License does not allow us to redistribute the "source" package
RESTRICT="mirror"

src_unpack() {
	unpack_makeself "hplip-${PV}-plugin.run"
}

src_install() {
	local hplip_arch=$(use amd64 && echo 'x86_64' || echo 'x86_32')

	insinto "${HPLIP_HOME}"/data/firmware
	doins *.fw.gz

	for plugin in *-${hplip_arch}.so; do
		local plugin_type=prnt
		case "${plugin}" in
			fax_*) plugin_type=fax ;;
			bb_*) plugin_type=scan ;;
		esac

		exeinto "${HPLIP_HOME}"/${plugin_type}/plugins
		newexe ${plugin} ${plugin/-${hplip_arch}}
	done

	mkdir -p "${D}/var/lib/hp" || die
	cat >> "${D}/var/lib/hp/hplip.state" << _EOF_ || die
[plugin]
installed = 1
eula = 1
version = ${PV}
_EOF_
}
