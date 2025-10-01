# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg
DESCRIPTION="BiliBili third-party client developed using Flutter"
HOMEPAGE="https://github.com/bggRGjQaUbCoE/PiliPlus"
PVER="1.1.4+4103"
SRC_URI="https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/1.1.4.6/PiliPlus_linux_${PVER}_amd64.tar.gz"
FPN="io.github.bggRGjQaUbCoE.${PN}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"
QA_PREBUILT="*"
DEPEND="net-libs/webkit-gtk:4.1"
RDEPEND="${DEPEND}"
src_unpack() {
   default
}
src_install() {
    local instdir="/opt/${PN}"
    dodir "${instdir}"
    insinto "${instdir}"
    doins piliplus
	fperms +x "${instdir}/piliplus"
    doins -r data
	insinto "${instdir}/lib"
    doins lib/*.so
    local wrapper_path="${WORKDIR}/${PN}"
    cat > "${wrapper_path}" <<-EOF
#!/bin/sh
cd "${instdir}" || exit 1
exec "${instdir}/piliplus" "\$@"
EOF
    dodir "/usr/libexec/${PN}"
	cp "${wrapper_path}" "${D}/usr/libexec/${PN}/${PN}"
	chmod +x "${D}/usr/libexec/${PN}/${PN}"
	dosym "/usr/libexec/${PN}/${PN}" "/usr/bin/${PN}"
	cat > "${WORKDIR}/${FPN}.desktop" <<-EOF
[Desktop Entry]
Version=${PV}
Name=PiliPlus
Comment=${DESCRIPTION}
Exec=piliplus
Terminal=false
Type=Application
Categories=Network;AudioVideo;Video;
EOF
    insinto /usr/share/applications
    doins "${WORKDIR}/${FPN}.desktop"
}
