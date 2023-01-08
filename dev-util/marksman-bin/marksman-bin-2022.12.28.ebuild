# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A language server for Markdown"
HOMEPAGE="https://github.com/artempyanykh/marksman"
SRC_URI="https://github.com/artempyanykh/marksman/releases/download/${PV//./-}/marksman-linux -> ${P}"

RESTRICT="strip mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}"/"${P}" marksman
}
