# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils multilib toolchain-funcs versionator

MY_PN="${PN%-bin}-stable"
SRC_BASE="https://dl.google.com/linux/direct/"
DESCRIPTION="A browser that combines a minimal design with sophisticated technology"
HOMEPAGE="http://www.google.com/chrome"
SRC_URI="amd64? ( ${SRC_BASE}${MY_PN}_current_amd64.deb ) x86? ( ${SRC_BASE}${MY_PN}_current_i386.deb )"
S="${WORKDIR}"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND="
	|| ( media-fonts/liberation-fonts media-fonts/corefonts )
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg:62
	>=sys-devel/gcc-4.2[-nocxx]
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/pango
	x11-misc/xdg-utils"

RESTRICT="mirror"

QA_EXECSTACK="opt/google/chrome/chrome"
QA_PRESTRIPPED="
	opt/google/chrome/chrome
	opt/google/chrome/chrome-sandbox
	opt/google/chrome/libavutil.so.50
	opt/google/chrome/libavformat.so.52
	opt/google/chrome/libavcodec.so.52
	opt/google/chrome/libffmpegsumo.so"
QA_TEXTRELS="opt/google/chrome/libavcodec.so.52
	opt/google/chrome/libffmpegsumo.so"

pkg_nofetch() {
	elog "Please download"
	for i in ${A}; do
		[[ ${i} = ${MY_PN}_* ]] && elog "${SRC_BASE}${i}"
	done
	elog "and save to ${DISTDIR}"
}

src_unpack() {
	for i in ${A}; do
		ar x "${DISTDIR}"/${i}
		if [[ ${i} = *.deb ]]; then
			if [[ -e "${WORKDIR}"/data.tar.lzma ]]; then
				mv "${WORKDIR}"/data.tar.lzma "${WORKDIR}"/${i%%_*}.tar.lzma
			elif [[ -e "${WORKDIR}"/data.tar.gz ]]; then
				mv "${WORKDIR}"/data.tar.gz "${WORKDIR}"/${i%%_*}.tar.gz
			else
				die "Can't find data from ${i}"
			fi
		fi
	done
}

src_install() {
	declare CHROME_HOME="/opt/google/chrome"

	cd "${D}"
	lzma -cd "${WORKDIR}"/${MY_PN}.tar.lzma | tar xvf - || die "Couldn't extract"
	rm -r "${D}"/{etc,usr/bin/google-chrome}

	sed -i "s|Exec=${CHROME_HOME//\//\\/}\/|Exec=|g" "${D}"${CHROME_HOME}/${PN%-bin}.desktop
	domenu "${D}"${CHROME_HOME}/${PN%-bin}.desktop
	rm "${D}"${CHROME_HOME}/${PN%-bin}.desktop

	if has_version ">=dev-libs/nss-3.12.5-r1" ; then 
		MY_NSS_SUB=""
	else
		MY_NSS_SUB="nss/"
	fi
	if has_version ">=dev-libs/nspr-4.8.3-r3" ; then
		MY_NSPR_SUB=""
	else
		MY_NSPR_SUB="nspr/"
	fi
	for i in ${MY_NSS_SUB}lib{nss{,util},smime,ssl}3.so.1d \
			${MY_NSPR_SUB}lib{pl{ds,c},nspr}4.so.0d ; do
		dosym /usr/$(get_libdir)/${i%.*} \
			${CHROME_HOME}/${i##*/}
	done

	cat <<EOF >"${D}"/usr/bin/google-chrome
#!/bin/sh
exec ${CHROME_HOME}/google-chrome \
	--enable-greasemonkey \
	--enable-user-scripts \
	--enable-extensions "\$@"
EOF
	fperms 0755 /usr/bin/google-chrome

	dosym /usr/$(get_libdir)/nsbrowser/plugins ${CHROME_HOME}/plugins
}

pkg_postinst() {
	elog "This Chrome binary package is from the developer preview channel.  It is"
	elog "not guaranteed to be stable or even usable."
	elog ""
	elog "Chrome's auto-update mechanism is only available for Debian-based"
	elog "distributions, and has been disabled."
	elog ""
	elog "Please see"
	elog "    http://dev.chromium.org/for-testers/bug-reporting-guidlines-for-the-mac-linux-builds"
	elog "before filing any bugs."
	if ! version_is_at_least 4.2 "$(gcc-version)" || [[ -z $(tc-getCXX) ]]; then
		einfo ""
		ewarn "This Chrome binary package depends on C++ libraries from >=sys-devel/gcc-4.2,"
		ewarn "which do not appear to be available.  Google Chrome may not run."
		ebeep
	fi
}
