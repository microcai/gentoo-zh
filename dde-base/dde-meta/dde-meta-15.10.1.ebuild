# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Deepin Desktop Enviroment (meta package)"
HOMEPAGE="https://www.deepin.org"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+policykit manual +terminal multimedia grub plymouth elogind systemd turbo kwin mutter extra screensaver"
REQUIRED_USE="^^ ( systemd elogind )
			?? ( kwin mutter )"

RDEPEND=">=dde-base/dde-control-center-4.10.0
		virtual/dde-wm[kwin?,mutter?]
		>=dde-base/startdde-3.14.0
		>=dde-base/dde-file-manager-4.8.4[screensaver?]
		>=dde-base/dde-launcher-4.6.8
		>=dde-base/dde-dock-4.9.7
		>=dde-base/deepin-desktop-base-2019.04.24
		>=dde-base/dde-session-ui-4.9.5[systemd?,elogind?]
		>=dde-base/dde-daemon-3.27.0[grub?,systemd?,elogind?]
		policykit? ( dde-base/dde-polkit-agent )
		turbo? ( dde-extra/deepin-turbo[systemd?,elogind?] )
		manual? ( >=dde-extra/deepin-manual-2.0.19 )
		terminal? ( dde-extra/deepin-terminal )
		multimedia? ( dde-extra/dde-meta-multimedia )
		extra? ( dde-extra/dde-meta-apps )
		plymouth? ( dde-extra/plymouth-theme-deepin )
		"

pkg_postinst() {
	use terminal && dfmterm deepin-terminal
}
