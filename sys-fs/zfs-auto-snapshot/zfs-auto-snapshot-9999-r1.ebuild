# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/zfsonlinux/${PN}.git"

inherit git-r3

DESCRIPTION="Automatic snapshots for ZFS on Linux"
HOMEPAGE="https://github.com/dajhorn/zfs-auto-snapshot/"
LICENSE="GPL-2"
KEYWORDS="amd64"
SLOT="0"
IUSE="+default-exclude"
DEPEND=""
RDEPEND="sys-fs/zfs
	virtual/cron"

DOCS=( README )

src_install() {
	default

	use default-exclude && for cronfile in /etc/cron.{d,daily,hourly,monthly,weekly}/${PN} ; do
		einfo "adjust $cronfile ..."
		sed -i "s/\(${PN}\)/\1 --default-exclude/" ${D}/$cronfile || die
	done
	# Remove execute flag for crontab files
	fperms a-x /etc/cron.d/${PN}
}
pkg_postinst() {
	use default-exclude || ewarn "without use default-exclude. all zfs filesystem will under all kind of snapshot."
	elog "use attribute com.sun:auto-snapshot to decide which filesystem to"
	elog "make snapshot. the rule is:"
	elog "zfs set com.sun:auto-snapshot=[true|false]"
	elog "or"
	elog "zfs set com.sun:auto-snapshot:<frequent|hourly|daily|weekly|monthly>=[true|false]"
	elog
	elog "ex."
	elog "# zfs set com.sun:auto-snapshot=false rpool"
	elog "# zfs set com.sun:auto-snapshot=true rpool"
	elog "# zfs set com.sun:auto-snapshot:weekly=true rpool"
	elog
	elog "for detail pls visit http://docs.oracle.com/cd/E19082-01/817-2271/ghzuk/"
	elog
	ewarn "if you are using fcron as system crontab. frequent snapshot may not"
	ewarn "work. you should add below setting to job list by execute"
	ewarn "'fcrontab -e' manually:"
	use default-exclude && \
		ewarn "*/15 * * * * zfs-auto-snapshot --default-exclude -q -g --label=frequent --keep=4  //" || \
		ewarn "*/15 * * * * zfs-auto-snapshot -q -g --label=frequent --keep=4  //"
	elog

}
