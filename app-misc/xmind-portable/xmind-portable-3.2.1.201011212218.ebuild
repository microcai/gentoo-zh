# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3

inherit eutils fdo-mime gnome2-utils

DESCRIPTION="XMind is a brainstorming and mind mapping software tool."
HOMEPAGE="www.xmind.net"
SRC_URI="http://dl2.xmind.net/xmind-downloads/${P}.zip"

LICENSE="EPL-1.0 LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome"

DEPEND=">=virtual/jre-1.5"
RDEPEND="${DEPEND}"

src_unpack() {
	unzip -d ${S} ${DISTDIR}/${P}.zip
}

src_configure() {
	case `arch` in
		"x86_64")	XDIR="XMind_Linux_64bit";;
		*) 	XDIR="XMind_Linux";;
	esac
	mv -v "$XDIR" XMind

	# force data instance & config area to be at home/.xmind directory
	sed -i -e '/-Dosgi\.instance\.area=.*/d' XMind/xmind-bin.ini || die
	sed -i -e '/-Dosgi\.configuration\.area=.*/d' XMind/xmind-bin.ini || die
	echo '-Dosgi.instance.area=@user.home/.xmind/workspace-cathy' >> XMind/xmind-bin.ini || die
	echo '-Dosgi.configuration.area=@user.home/.xmind/configuration-cathy' >> XMind/xmind-bin.ini || die
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir   /usr/lib/xmind
	insinto /usr/lib/xmind
	doins   -r Commons
	doins   -r XMind

	exeinto /usr/lib/xmind/XMind
	doexe   XMind/xmind
	doexe   XMind/xmind-bin
	dosym   /usr/lib/xmind/XMind/xmind /usr/bin/xmind

	# insall icons
	local res
		for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${FILESDIR}/xmind.${res}.png xmind.png || die
	done

	# insall MIME type
	insinto /usr/share/mime/packages
	doins   "${FILESDIR}"/x-xmind.xml || die

	# make desktop entry
	make_desktop_entry xmind XMind xmind Office "MimeType=application/x-xmind;"
	sed -i -e "/^Exec/s/$/ %F/" "${ED}"/usr/share/applications/*.desktop || die

	# gnome schemas and thumbnailer
	if use gnome; then
		insinto /etc/gconf/schemas
		doins "${FILESDIR}"/xmind.schemas || die
		dobin "${FILESDIR}"/xmind-thumbnailer || die
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
