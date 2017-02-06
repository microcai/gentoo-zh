# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1 gnome2-utils rpm versionator

DOWNLOAD_PAGE="http://www.bitdefender.com/site/Downloads/browseEvaluationVersion/2/80/"
SRC_NAME_BASE="BitDefender-Antivirus-Scanner-$(replace_version_separator 2 '-').linux-gcc4x.ARCH.rpm.run"
DESCRIPTION="Antivirus and antispyware scanner for both UNIX-based and Windows-based partitions"
HOMEPAGE="http://www.bitdefender.com/PRODUCT-80-en--BitDefender-Antivirus-Scanner-for-Unices.html"
SRC_URI="
	amd64? ( ${SRC_NAME_BASE/ARCH/amd64} )
	x86? ( ${SRC_NAME_BASE/ARCH/i586} )"

LICENSE="BitDefender-ASU-EUSLA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion examples gtk"

DEPEND=""
RDEPEND="!app-antivirus/bitdefender-console
	gtk? (
		>=dev-libs/atk-1.22.0
		>=dev-libs/glib-2.18.4-r1
		>=media-libs/fontconfig-2.5.0-r1
		>=x11-libs/gtk+-2.12.11
		>=x11-libs/libSM-1.1.0
		>=x11-libs/libX11-1.1.2-r1
		>=x11-libs/libXcursor-1.1.8
		>=x11-libs/libXext-1.0.3
		>=x11-libs/libXfixes-4.0.3
		>=x11-libs/libXi-1.1.2
		>=x11-libs/libXinerama-1.0.2
		>=x11-libs/libXrender-0.9.2
		>=x11-libs/pango-1.24.2 )
	>=sys-devel/gcc-4.1.2
	>=sys-libs/glibc-2.3.1"

RESTRICT="fetch"

QA_PRESTRIPPED="
	opt/BitDefender-scanner/bin/bdgui
	opt/BitDefender-scanner/bin/bdscan
	opt/BitDefender-scanner/bin/ultool
	opt/BitDefender-scanner/var/lib/scan/bdcore.so
	opt/BitDefender-scanner/var/lib/scan/bdupd.so"
QA_EXECSTACK="
	opt/BitDefender-scanner/var/lib/scan/bdcore.so
	opt/BitDefender-scanner/var/lib/scan/bdupd.so"

BASE="BitDefender-scanner"
DIR="opt/$BASE"
CONF="bdscan.conf"

pkg_nofetch() {
	einfo
	einfo " Due to the software provider's restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${DOWNLOAD_PAGE}"
	einfo " 2. Enter all the details and click submit"
	einfo " 3. You’ll receive a mail with the link to the download page"
	einfo " 4. Go to the link and click BitDefender Antivirus scanner for Unices (Linux, FreeBSD)."
	einfo " 5. On the next page click Download."
	einfo " 6. Click EN_FR_BR_RO/ on the next page."
	einfo " 7. On the following page click Linux."
	einfo " 8. Download ${A}"
	einfo " 9. Move the file to ${DISTDIR}"
	einfo
}

pkg_setup() { enewgroup bitdefender; }

src_unpack() {
	unpack_makeself ${SRC_NAME}

	mkdir ${P}
	mv *.rpm ${P}
	cd ${P}
	rpm_unpack ./${PN}-$(get_version_component_range 1-2)-$(get_version_component_range 3).*.rpm
	if use gtk ; then
		rpm_unpack ./${PN}-gui-*.rpm
	fi
	rm *.rpm
}

src_install() {
	cp -r * "${D}" || die "Install failed"

	cat > 82${PN} << DONE
LDPATH=/$DIR/var/lib
MANPATH=/$DIR/share/man
DONE
	doenvd 82${PN}

	dodir /opt/bin
	cd "${D}"/$DIR/bin && for bin in *; do
		dosym /$DIR/bin/${bin} /opt/bin
	done

	mv "${D}"/{$DIR/share/doc/examples,usr/share}/icons
	sed -i -e 's|^Icon=.*|Icon=bitdefender|' "${D}"/usr/share/applications/bdgui.desktop

	dodir /etc/$BASE
	dosym /$DIR/etc/certs /etc/$BASE

	cd "${D}"/$DIR

	if use bash-completion; then
		dobashcompletion share/contrib/bash_completion/bdscan
		rm -r share/contrib
	fi

	use examples || rm -r share/{doc/examples,integration}

	# generate configuration
	BDSCAN_CONF=${D}/etc/$BASE/$CONF
	sed "s|\$\$DIR|\/$DIR|g" < etc/$CONF.dist > "${BDSCAN_CONF}"

	# add "LicenseAccepted = True" to $CONF
	echo "" >> "${BDSCAN_CONF}"
	echo "LicenseAccepted = True" >> "${BDSCAN_CONF}"

	# fix obsolete update server
	sed -i -e "s|upgrade\.bitdefender\.com|upgrade1\.bitdefender\.com|g" "${BDSCAN_CONF}"

	if use gtk ; then
		# generate GUI configuration
		sed "s|\$\$DIR|\/$DIR|g" < etc/bdgui.conf.dist > "${D}"/etc/$BASE/bdgui.conf

		# extract the skin
		tar -C var/skins -xzf var/skins/Default.tar.gz
		rm var/skins/Default.tar.gz
	fi
}

pkg_preinst() { gnome2_icon_savelist; }

pkg_postinst() {
	cd /$DIR

	# extract the plugins
	mkdir -p var/lib/scan/Plugins
	tar -C var/lib/scan/Plugins \
		-kxf share/engines/Plugins.tar.gz 2>&1 | \
		grep -v "Cannot open: File exists" | \
		grep -v "Exiting with failure status due to previous errors"

	chgrp -R bitdefender . /etc/$BASE
	chmod +s bin/ultool

	gnome2_icon_cache_update

	elog "You must be in the bitdefender group to use BitDefender Antivirus Scanner."
}

pkg_prerm() {
	killall_() {
		einfo "Kill $1..."
		killall $1 2>/dev/null
		sleep 2
		killall -9 $1 2>/dev/null
		einfo "$1 is terminated!"
	}
	killall_ bdscan
	use gtk && killall_ bdgui
}

pkg_postrm() {
	# cleanup $DIR
	find /$DIR -depth -type d -exec rmdir -p --ignore-fail-on-non-empty {} \; >/dev/null 2>&1 || true

	# adjust the permissions of the files left behind (if any)
	if [ -d /$DIR ]; then
		chown -R root:root /$DIR >/dev/null 2>&1 || true
	fi

	gnome2_icon_cache_update;
}
