#Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake git-r3 optfeature
EGIT_REPO_URI="${HOMEPAGE}"

DESCRIPTION="A GUI management tool to make managing a Btrfs filesystem easier."
HOMEPAGE="https://gitlab.com/btrfs-assistant/btrfs-assistant"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtbase:6
	dev-qt/qtsvg:6
"
BDEPEND="${DEPEND}"
RDEPEND="
	media-fonts/noto
	sys-auth/polkit
	sys-fs/btrfs-progs
	${DEPEND}
"

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "auto snapshot" app-backup/snapper
	optfeature "auto balance and defrag" sys-fs/btrfsmaintenance
}
