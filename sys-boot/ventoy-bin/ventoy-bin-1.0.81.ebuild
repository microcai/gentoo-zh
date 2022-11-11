# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A new multiboot USB solution"
HOMEPAGE="http://www.ventoy.net"
SRC_URI="https://github.com/ventoy/Ventoy/releases/download/v${PV}/ventoy-${PV}-linux.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="strip"

DEPEND="
	app-shells/bash
	sys-fs/dosfstools
	sys-apps/util-linux
	app-arch/xz-utils
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/ventoy-${PV}

CARCH="x86_64"

src_prepare() {
	# Decompress tools
	pushd tool/$CARCH
	for file in *.xz; do
		xzcat $file > ${file%.xz}
		chmod +x ${file%.xz}
	done

	# Cleanup .xz crap
	rm -fv ./*.xz
	popd

	# Apply sanitize patch
	patch --verbose -p0 < "${FILESDIR}/sanitize.patch"

	# Log location
	sed -i 's|log\.txt|/var/log/ventoy.log|g' WebUI/static/js/languages.js tool/languages.json

	# Non-POSIX compliant scripts
	sed -i 's|bin/sh|usr/bin/env bash|g' tool/{ventoy_lib.sh,VentoyWorker.sh}

	# Clean up unused binaries
	# Preserving mkexfatfs and mount.exfat-fuse because exfatprogs is incompatible
	for binary in xzcat hexdump; do
		rm -fv tool/$CARCH/$binary
	done
	default
}

src_install() {
	insopts -m0644
	insinto /opt/ventoy/boot/
	doins boot/*
	insinto /opt/ventoy/ventoy/
	doins ventoy/*
	insopts -m0755
	insinto /opt/ventoy/tool/
	doins tool/*.{cer,glade,json,sh,xz}
	insinto /opt/ventoy/tool/$CARCH/
	doins tool/$CARCH/*
	insinto /opt/ventoy/
	doins *.sh plugin WebUI "VentoyGUI.$CARCH"

	# Install .desktop
	insopts -m0644
	insinto /usr/share/pixmaps/
	newins WebUI/static/img/VentoyLogo.png ventoy.png
	domenu "${FILESDIR}/ventoy.desktop"

	# Link system binaries
	for binary in xzcat hexdump; do
		ln -s /usr/bin/$binary ./
		insopts -m0755
		insinto /opt/ventoy/tool/$CARCH
		doins $binary
	done

	dobin "${FILESDIR}"/ventoy{,gui,web,plugson,-{,extend-}persistent}

	rm ../../image/opt/ventoy/tool/x86_64/Ventoy2Disk.gtk2
}
