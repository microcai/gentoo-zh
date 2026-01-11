# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A new multiboot USB solution"
HOMEPAGE="http://www.ventoy.net"
SRC_URI="https://github.com/ventoy/Ventoy/releases/download/v${PV}/ventoy-${PV}-linux.tar.gz"

S="${WORKDIR}"/ventoy-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	sys-fs/dosfstools
	|| ( sys-fs/exfatprogs sys-fs/exfat-utils )
	sys-fs/fuse-exfat
	sys-block/parted
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
# sys-fs/fuse-exfat is needed for mount, without it:
# mount: /mnt: unknown filesystem type 'exfat'

QA_PREBUILT="*" # Against "does not respect LDFLAGS"

CARCH="x86_64"

src_prepare() {
	# Decompress tools
	pushd tool/$CARCH || die
	for file in *.xz; do
		xzcat "$file" >"${file%.xz}" || die
		chmod +x "${file%.xz}" || die
	done

	# Cleanup .xz crap
	rm -fv ./*.xz || die
	popd || die

	# Apply sanitize patch
	eapply -p0 "${FILESDIR}/sanitize.patch"

	# Log location
	sed -i 's|log\.txt|/var/log/ventoy.log|g' WebUI/static/js/languages.js tool/languages.json || die

	# Non-POSIX compliant scripts
	sed -i 's|bin/sh|usr/bin/env bash|g' tool/{ventoy_lib.sh,VentoyWorker.sh} || die

	# Clean up unused binaries
	# Preserving mkexfatfs and mount.exfat-fuse because exfatprogs is incompatible
	for binary in xzcat hexdump; do
		rm -fv tool/$CARCH/$binary || die
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
	doins ./*.sh plugin WebUI "VentoyGUI.$CARCH"

	# Install .desktop
	insopts -m0644
	insinto /usr/share/pixmaps/
	newins WebUI/static/img/VentoyLogo.png ventoy.png
	domenu "${FILESDIR}/ventoy.desktop"

	# Link system binaries
	for binary in xzcat hexdump; do
		dosym -r /usr/bin/$binary /opt/ventoy/tool/$CARCH/$binary
	done

	dobin "${FILESDIR}"/ventoy{,gui,web,plugson,-{,extend-}persistent}

	rm "${D}"/opt/ventoy/tool/x86_64/Ventoy2Disk.gtk2 || die
	rm "${D}"/opt/ventoy/tool/x86_64/Ventoy2Disk.qt5 || die
}
