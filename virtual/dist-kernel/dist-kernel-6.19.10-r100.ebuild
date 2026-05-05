# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual to depend on any Distribution Kernel"

SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="kernel_linux? ( ~sys-kernel/xanmod-kernel-${PV} )"
