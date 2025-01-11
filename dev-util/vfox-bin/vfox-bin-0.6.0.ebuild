# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="A cross-platform version manager, extendable via plugins"
HOMEPAGE="https://vfox.lhan.me/ https://github.com/version-fox/vfox"

SRC_URI="
	amd64? ( https://github.com/version-fox/vfox/releases/download/v${PV}/vfox_${PV}_linux_x86_64.deb )
	x86? ( https://github.com/version-fox/vfox/releases/download/v${PV}/vfox_${PV}_linux_i386.deb )
	arm64? ( https://github.com/version-fox/vfox/releases/download/v${PV}/vfox_${PV}_linux_aarch64.deb )
	arm? ( https://github.com/version-fox/vfox/releases/download/v${PV}/vfox_${PV}_linux_armv7.deb )
"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="app-shells/bash"
RDEPEND+=" !dev-util/vfox"

src_install() {
	default

	dobin usr/bin/vfox

	insinto /usr/share/bash-completion/completions
	doins usr/share/bash-completions/completions/vfox

	insinto /usr/share/zsh/vendor-completions
	doins usr/share/zsh/vendor-completions/_vfox
}
