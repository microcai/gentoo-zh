# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit nsplugins

DESCRIPTION="支付宝安全控件对密码输入进行保护"
HOMEPAGE="https://securitycenter.alipay.com/sc/aliedit/intro.htm"
SRC_URI="https://download.alipay.com/alipaysc/linux/${PN}/${PV}/${PN}.tar.gz"

LICENSE="Other"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# we can not mirror it
RESTRICT="mirror"

DEPEND=""
RDEPEND="x11-libs/gtk+:2
	media-libs/libpng:1.2"

S="${WORKDIR}"

src_unpack(){
	unpack ${A}
	elog "unpacking ${PN}.sh"
	ARCHIVE=$( awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }'  "${PN}.sh" )
	tail -n+$ARCHIVE "${PN}.sh" | tar xzvm  || die "unpack ${PN}.sh failed"
	rm "${PN}.sh"
}

src_compile(){
	echo make: nothing to do for all
}

src_install(){
	dodir /opt/alipay/nsplugins/
	exeinto /opt/alipay/nsplugins/
	if use amd64 ; then
		doexe lib/libaliedit64.so
		inst_plugin /opt/alipay/nsplugins/libaliedit64.so
	fi
	if use x86 ; then
		doexe lib/libaliedit32.so
		inst_plugin /opt/alipay/nsplugins/libaliedit32.so
	fi
}
