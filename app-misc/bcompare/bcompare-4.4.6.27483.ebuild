# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Beyond Compare -- Compare, sync, and merge files and folders"
HOMEPAGE="https://www.scootersoftware.com/"
SRC_URI="
	x86? ( https://www.scootersoftware.com/bcompare-${PV}.i386.tar.gz )
	amd64? ( https://www.scootersoftware.com/bcompare-${PV}.x86_64.tar.gz )"

LICENSE="Bcompare"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
RDEPEND=""
QA_PRESTRIPPED="
	/opt/${PN}/lib/beyondcompare/lib7z.so
	/opt/${PN}/lib/beyondcompare/BCompare
	/opt/${PN}/lib/beyondcompare/qt4/libQtGui.so.4
	/opt/${PN}/lib/beyondcompare/qt4/libQtCore.so.4
"
QA_FLAGS_IGNORED="
	/opt/bcompare/lib64/beyondcompare/bcmount64
	/opt/bcompare/lib64/beyondcompare/bcmount32
	/opt/bcompare/lib64/beyondcompare/lib7z.so
	/opt/bcompare/lib64/beyondcompare/libQt4Pas.so.5
	/opt/bcompare/lib64/beyondcompare/BCompare
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_konq.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_konq.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_kde5.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_kde5.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_kde.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare_ext_kde.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-thunarx-3.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-thunarx-3.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-thunarx-2.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-thunarx-2.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-nemo.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-nemo.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-nautilus.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-nautilus.amd64.so.ext4
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-nautilus.amd64.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-caja.i386.so
	/opt/bcompare/lib64/beyondcompare/ext/bcompare-ext-caja.amd64.so
	/opt/bcompare/lib64/beyondcompare/qt4/libQtGui.so.4
	/opt/bcompare/lib64/beyondcompare/qt4/libQtCore.so.4
"
QA_PRESTRIPPED="
	/opt/bcompare/lib64/beyondcompare/lib7z.so
	/opt/bcompare/lib64/beyondcompare/BCompare
	/opt/bcompare/lib64/beyondcompare/qt4/libQtGui.so.4
	/opt/bcompare/lib64/beyondcompare/qt4/libQtCore.so.4
"

src_unpack() {
	unpack ${A}
}

src_install() {
	local targetdir="/opt/bcompare"
	local LAUNCHER="bcompare/bin/bcompare"

	insinto "${targetdir}"
	sed -i ./install.sh -e 's/^# Create desktop entry and place.*/exit 0/g' || die
	sed -i ./install.sh -e "s%^# Copy the files.*%BC_BIN=\"$D/\$BC_BIN\"; BC_LIB=\"$D/\$BC_LIB\";%g" || die
	sed -i ./install.sh -e "s/^\texit 1.*//g" || die
	./install.sh --prefix="${targetdir}" || die

	dosym "../../opt/${LAUNCHER}" "/usr/bin/bcompare"
}
