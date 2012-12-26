# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils versionator

MY_PN="FoxitReader"
MY_P="${MY_PN}-${PV}"

SRC_BASE="cdn04.foxitsoftware.com/pub/foxit/reader/desktop/linux/"
DESCRIPTION="Foxit Reader for desktop Linux"
HOMEPAGE="http://www.foxitsoftware.com/pdf/desklinux"
SRC_URI="${SRC_BASE}/$(get_major_version).x/$(get_version_component_range 1-2)/enu/${MY_P}.tar.bz2"

LICENSE="Foxit-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LANGS="de fr ja zh_CN zh_TW"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

DEPEND=""
RDEPEND="
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-gtklibs )
	x86? ( media-libs/freetype:2
		>=x11-libs/gtk+-2.12 )"

S="${WORKDIR}/$(get_version_component_range 1-2)-release"
RESTRICT="mirror strip"

src_install() {
	mv "${S}"/Readme.txt "${WORKDIR}"/README
	dodoc "${WORKDIR}"/README

	ebegin "Installing package"
		for X in ${LANGS} ; do
			if use linguas_${X} ; then
				insinto /usr/share/locale/${X}/LC_MESSAGES
				doins "${S}"/po/${X}/${MY_PN}.mo \
					|| die "failed to install languages files"
			fi
		done
		rm -R "${S}"/po

		insinto /opt/${PN}
		doins "${S}"/* || die "failed to install program files"
		fperms 0755 /opt/${PN}/${MY_PN}
	eend $? || die "failed to install package"

	doicon "${FILESDIR}"/${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop

	make_wrapper ${PN} /opt/${PN}/${MY_PN}
}
