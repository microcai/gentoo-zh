# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-182-r3.ebuild,v 1.5 2012/05/04 19:09:16 jdhore Exp $

EAPI=4

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev/udev.html http://git.kernel.org/?p=linux/hotplug/udev.git;a=summary"

LICENSE="GPL-2"
SLOT="0"
IUSE="build selinux debug +rule_generator hwdb gudev introspection
	keymap floppy doc static-libs +openrc"

RDEPEND=">=sys-apps/systemd-${PV}"

DEPEND="!<sys-fs/udev-183"

KEYWORDS="~amd64 ~x86"

