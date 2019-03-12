# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime versionator

MY_PV1=$(get_major_version)
MY_PV2=$(get_version_component_range 1-2)

DESCRIPTION="A free PDF document viewer, featuring small size, quick startup, and fast page rendering"
HOMEPAGE="https://www.foxitsoftware.cn/downloads/"
SRC_URI="http://101.110.118.70/cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.${PV}.x64.run.tar.gz"
LICENSE="${PN}"
SLOT="0"
KEYWORDS="amd64 -*"
IUSE=""

RDEPEND="
	dev-libs/atk
		dev-libs/glib:2
		media-libs/freetype:2
		net-print/cups
		x11-libs/cairo
		x11-libs/gtk+:2
		x11-libs/pango
"

S="${WORKDIR}/${PN}-extracted"

QA_PRESTRIPPED="/opt/FoxitReader/FoxitReader"

src_unpack(){
  local _file
  local _line
  local _position


  unpack ${A};
  mkdir ${PN}-installer;

  _file="FoxitReader.enu.setup.2.4.4.0911(r057d814).x64.run"
  LANG=C grep --only-matching --byte-offset --binary \
              --text $'7z\xBC\xAF\x27\x1C' "${_file}" | cut -f1 -d: |
         while read _position
         do
           dd if="${_file}" \
              bs=1M iflag=skip_bytes status=none skip=${_position} \
              of="${PN}-installer/bin-${_position}.7z"
         done

	mkdir ${WORKDIR}/${PN}-extracted;
	cd ${PN}-installer;
	for _file in *.7z
	do
		7z -bd -bb0 -y x -o${WORKDIR}/${PN}-extracted ${_file} 1>/dev/null 2>&1 || true
	done
}

src_compile(){
	epatch_user;

	# Remove unneeded files
  rm "Activation" "Activation.desktop" "Activation.sh" \
     "countinstalltion" "countinstalltion.sh" \
     "installUpdate" "ldlibrarypath.sh" \
     "maintenancetool.sh" "Uninstall.desktop" \
     "Update.desktop" "updater" "updater.sh" "postinst" "prerm" "FoxitReader.sh"

  find -type d -name ".svn" -exec rm -rf {} +
  find -type f -name ".directory" -exec rm -rf {} +
  find -type f -name "*~" -exec rm {} +

  find -type f -name "libQt5*~" -exec rm {} +

  rm -rf lib platforms imageformats/ printsupport/ sqldrivers/ platforminputcontexts/ platformthemes
}

src_install() {
	insinto /opt/${PN}

	cp -r * ${D}/opt/${PN} || die
	insopts -m755
	dosym /opt/${PN}/FoxitReader /usr/bin/${PN} || die
	doicon "${FILESDIR}"/${PN}.png || die
	make_desktop_entry ${PN} ${PN} ${PN} "Application;Office;Viewer;" "MimeType=application/pdf;"

}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
