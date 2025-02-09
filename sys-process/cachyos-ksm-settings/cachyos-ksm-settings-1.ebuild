# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd tmpfiles

DESCRIPTION="Package for easy configuration of KSM via systemd"
HOMEPAGE="https://github.com/CachyOS/CachyOS-Settings"

S="${FILESDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sys-apps/systemd-256
	!sys-process/uksmd
"

CONFIG_CHECK="~KSM"

src_install() {
	systemd_install_dropin gdm.service 10-systemd-ksm.conf
	systemd_install_dropin sddm.service 10-systemd-ksm.conf
	systemd_install_dropin lightdm.service 10-systemd-ksm.conf
	systemd_install_dropin ly.service 10-systemd-ksm.conf
	systemd_install_dropin user@.service 10-systemd-ksm.conf
	systemd_install_dropin getty@.service 10-systemd-ksm.conf
	dotmpfiles 10-enable-ksm-by-default.conf
	dobin ksmctl ksmstats
}

pkg_postinst() {
	tmpfiles_process 10-enable-ksm-by-default.conf
}
