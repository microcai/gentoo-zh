# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop toolchain-funcs xdg

DESCRIPTION="Netease Cloud Music, converted from .deb package"
HOMEPAGE="https://music.163.com"
SRC_URI="https://d1.music.126.net/dmusic/${PN}_${PV}_amd64_ubuntu_20190428.deb"

LICENSE="NetEase BSD"
SLOT="0"
RESTRICT="strip mirror"
KEYWORDS="-* ~amd64"

DEPEND="media-video/vlc[taglib]"
RDEPEND="${DEPEND}
	sys-devel/binutils
	x11-libs/gtk+:3
	net-dns/avahi
	sys-auth/nss-mdns
	net-libs/libgssglue
"
S="${WORKDIR}"

src_compile() {
	$(tc-getCC) ${CFLAGS} -fPIC -shared -I /usr/include/vlc/plugins/ -o libnetease-patch.so "${FILESDIR}"/patch.c || die
	default
}

src_install() {
	local OPN="opt/netease/${PN}"
	insinto /${OPN}
	doins -r libnetease-patch.so "${FILESDIR}"/${PN}.bash ${OPN}/{${PN},plugins}
	dosym -r /${OPN}/${PN}.bash /usr/bin/${PN}

	insinto /${OPN}/libs
	doins -r ${OPN}/libs/qcef
	for dol in $(cat "${FILESDIR}"/doinslib); do
		doins ${OPN}/libs/${dol}
	done
	fperms +x /${OPN}/{libnetease-patch.so,${PN},${PN}.bash,libs/qcef/chrome-sandbox}

	gzip -d usr/share/doc/${PN}/*.gz || die
	dodoc usr/share/doc/${PN}/*

	doicon -s scalable usr/share/icons/hicolor/scalable/apps/${PN}.svg
	domenu usr/share/applications/${PN}.desktop
}
