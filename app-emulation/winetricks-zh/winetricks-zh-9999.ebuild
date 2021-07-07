# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils eutils git-r3

EGIT_REPO_URI="https://github.com/hillwoodroc/winetricks-zh.git"

wtg="winetricks-gentoo-2012.11.24"

DESCRIPTION="winetricks fork for chinese to install QQ"
HOMEPAGE="http://winetricks.org http://wiki.winehq.org/winetricks"

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND=""
RDEPEND="app-emulation/winetricks"

# Tests require network access and run Wine, which is unreliable from a portage environment.
RESTRICT="test"

src_install() {
	insinto /opt/winetricks-zh
	doins -r *
	fperms +x /opt/winetricks-zh/winetricks-zh

	dosym ../../opt/winetricks-zh/winetricks-zh /usr/bin/winetricks-zh
}
