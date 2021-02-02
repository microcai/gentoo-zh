# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils eutils git-r3

EGIT_REPO_URI="https://github.com/hillwoodroc/winetricks-zh.git"
KEYWORDS="~amd64 ~x86"

wtg=winetricks-gentoo-2012.11.24

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
	dodir /usr/bin
	dosym /opt/winetricks-zh/winetricks-zh /usr/bin/winetricks-zh
}
