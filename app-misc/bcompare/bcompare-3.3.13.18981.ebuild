# Copyright 2016 Chun-Yu Lee (Mat) <matlinuxer2@gmail.com>
# Distributed under the terms of the MIT License
# $Header: $

EAPI=5

inherit eutils user

DESCRIPTION="Beyond Compare -- Compare, sync, and merge files and folders"
HOMEPAGE="http://www.scootersoftware.com/"
SRC_URI="
	x86? ( http://www.scootersoftware.com/bcompare-${PV}.tar.gz )
	amd64? ( http://www.scootersoftware.com/bcompare-${PV}.tar.gz )"

LICENSE="Bcompare"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_install() {
	local targetdir="/opt/bcompare"
	local LAUNCHER="bcompare/bin/bcompare"

	insinto "${targetdir}"
	sed -i ./install.sh -e 's/^# Create desktop entry and place.*/exit 0/g'
	sed -i ./install.sh -e "s%^# Copy the files.*%BC_BIN=\"$D/\$BC_BIN\"; BC_LIB=\"$D/\$BC_LIB\";%g"
	sed -i ./install.sh -e "s/^\texit 1.*//g"
	./install.sh --prefix="${targetdir}"

	dodir /opt/bin
	dosym /opt/${LAUNCHER} /opt/bin/${LAUNCHER/*bin\/}
}
