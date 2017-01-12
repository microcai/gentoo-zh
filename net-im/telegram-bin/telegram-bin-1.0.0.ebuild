# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed."
HOMEPAGE="https://telegram.org/"

SRC_URI="
	amd64? ( https://updates.tdesktop.com/tlinux/tsetup.${PV}.tar.xz )
	x86? ( https://updates.tdesktop.com/tlinux32/tsetup32.${PV}.tar.xz )
"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RESTRICT="strip mirror"

DEPEND="
	x11-libs/libX11
	x11-libs/libxcb
	dev-libs/glib
	x11-libs/libXau
	x11-libs/libXdmcp
"

RDEPEND="${DEPEND}"

MY_PN="Telegram"
S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto "/opt/${PN}/"
	doins -r ${S}/*

	fperms +x "/opt/${PN}/${MY_PN}"

	exeinto "/opt/bin/"
	doexe "${FILESDIR}/${MY_PN}"
	
	newmenu "${FILESDIR}/telegramdesktop-r1.desktop" "${MY_PN}.desktop"

	newicon "${FILESDIR}/icon.png" "${MY_PN}.png"
}
