# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-libs/fontconfig/fontconfig-2.3.2.ebuild,v 1.2 2006/07/13 02:43:47 scsi Exp $

inherit eutils

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.gz"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="zh_TW"

DEPEND=">=media-libs/freetype-2.1.4
	>=dev-libs/expat-1.95.3"

src_unpack() {

	unpack ${A}
	cd ${S}

	local PPREFIX="${FILESDIR}/patch/${PN}"

	# Add our local fontpaths (duh dont forget!)
	epatch ${PPREFIX}-2.2-local_fontdir-r1.patch

	use zh_TW && epatch ${PPREFIX}-${PV}-firefly-20041117.patch.bz2

	epunt_cxx #74077

}

src_compile() {

	[ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	# disable docs only disables docs generation (!)
	econf --disable-docs \
		--with-docdir=/usr/share/doc/${PF} \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		--with-default-fonts=/usr/share/fonts || die

	# this triggers sandbox, we do this ourselves
	sed -i "s:fc-cache/fc-cache -f -v:sleep 0:" Makefile

	emake -j1 || die

}

src_install() {

	make DESTDIR=${D} install || die

	insinto /etc/fonts
	doins ${S}/fonts.conf
	newins ${S}/fonts.conf fonts.conf.new

	cd ${S}

	newman fc-cache/fc-cache.man fc-cache.1
	newman fc-list/fc-list.man fc-list.1
	newman src/fontconfig.man fontconfig.3
	dodoc AUTHORS ChangeLog NEWS README

}

pkg_postinst() {

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	ewarn "Please make fontconfig related changes to /etc/fonts/local.conf,"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	mv -f ${ROOT}/etc/fonts/fonts.conf.new ${ROOT}/etc/fonts/fonts.conf
	rm -f ${ROOT}/etc/fonts/._cfg????_fonts.conf

	if [ "${ROOT}" = "/" ]
	then
		echo
		einfo "Creating font cache..."
		/usr/bin/fc-cache -f
	fi

}
