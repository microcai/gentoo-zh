# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils mozilla-launcher mozextension

MY_PV="3.7a1pre"
MY_P="${PN/-bin/}-${MY_PV}"

DESCRIPTION="Firefox Web Browser"
REL_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/2009-12-30-03-tracemonkey"
SRC_URI="
	x86? ( ${REL_URI}/firefox-${MY_PV}.en-US.linux-i686.tar.bz2 )
	amd64? ( ${REL_URI}/firefox-${MY_PV}.en-US.linux-x86_64.tar.bz2 )"
HOMEPAGE="http://www.mozilla.com/firefox"
RESTRICT="strip primaryuri"

KEYWORDS=""
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="restrict-javascript"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/dbus-glib
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	>=x11-libs/gtk+-2.2
	>=media-libs/alsa-lib-1.0.16"

PDEPEND="restrict-javascript? ( www-plugins/noscript )"

S="${WORKDIR}/firefox"

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/firefox

	# Install icon and .desktop for menu entry
	newicon "${S}"/chrome/icons/default/default48.png ${PN}-icon.png
	domenu "${FILESDIR}"/icon/${PN}.desktop

	# Add StartupNotify=true bug 237317
	if use startup-notification; then
		echo "StartupNotify=true" >> "${D}"/usr/share/applications/${PN}.desktop
	fi

	# Install firefox in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

		# Create /usr/bin/firefox-bin
		dodir /usr/bin/
		cat <<EOF >"${D}"/usr/bin/firefox-bin
#!/bin/sh
unset LD_PRELOAD
exec /opt/firefox/firefox "\$@"
EOF
		fperms 0755 /usr/bin/firefox-bin

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10firefox-bin

	# install ldpath env.d
	doenvd "${FILESDIR}"/71firefox-bin

	rm -rf "${D}"${MOZILLA_FIVE_HOME}/plugins
	dosym /usr/"$(get_libdir)"/nsbrowser/plugins ${MOZILLA_FIVE_HOME}/plugins
}

pkg_postinst() {
	if ! has_version 'gnome-base/gconf' || ! has_version 'gnome-base/orbit' \
		|| ! has_version 'net-misc/curl'; then
		einfo
		einfo "For using the crashreporter, you need gnome-base/gconf,"
		einfo "gnome-base/orbit and net-misc/curl emerged."
		einfo
	fi
	if has_version 'net-misc/curl' && built_with_use --missing \
		true 'net-misc/curl' nss; then
		einfo
		einfo "Crashreporter won't be able to send reports"
		einfo "if you have curl emerged with the nss USE-flag"
		einfo
	fi
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
