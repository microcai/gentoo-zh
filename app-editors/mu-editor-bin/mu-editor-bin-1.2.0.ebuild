# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A simple Python editor for beginner programmers"
HOMEPAGE="
	https://github.com/mu-editor/mu
	https://pypi.org/project/mu-editor
"
SRC_URI="https://github.com/mu-editor/mu/releases/download/v${PV}/MuEditor-Linux-${PV}-x86_64.tar"

S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_DESKTOP_FILE="usr/share/applications/mu.codewith.editor.desktop"

src_install() {
	newbin "Mu_Editor-${PV}-x86_64.AppImage" mu-editor
	domenu "${FILESDIR}/mu.codewith.editor.desktop"
	doicon -s 256 "${FILESDIR}/mu.codewith.editor.png"
}
