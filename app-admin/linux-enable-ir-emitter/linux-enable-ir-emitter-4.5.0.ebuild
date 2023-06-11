# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Enable infrared emitter on Linux for cameras that are not directly supported (binary)"
HOMEPAGE="https://github.com/EmixamPP/linux-enable-ir-emitter"
SRC_URI="https://github.com/EmixamPP/linux-enable-ir-emitter/releases/download/${PV}/linux-enable-ir-emitter-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/linux-enable-ir-emitter-${PV}"

src_unpack() {
    default
    mkdir -p "${S}"
    tar -C "${S}" --no-same-owner -h -xzf "${DISTDIR}/${A}"
}

src_install() {
    insinto /usr/bin
    doins usr/bin/linux-enable-ir-emitter

    insinto /usr/lib/systemd/system
    doins usr/lib/systemd/system/linux-enable-ir-emitter.service

    insinto /usr/lib64
    doins -r usr/lib64/linux-enable-ir-emitter
	fperms +x /usr/lib64/linux-enable-ir-emitter/linux-enable-ir-emitter.py
	fperms -R +x /usr/lib64/linux-enable-ir-emitter/bin

    insinto /usr/share/bash-completion/completions
    doins usr/share/bash-completion/completions/linux-enable-ir-emitter

    insinto /etc
    doins -r etc/linux-enable-ir-emitter
}

pkg_postinst() {
    einfo "To enable your infrared emitter, please run 'sudo linux-enable-ir-emitter configure'."
}
