# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/kde-misc/kcpufreq/kcpufreq-0.3-r1.ebuild,v 1.1 2005/04/11 01:47:03 scsi Exp $

inherit kde
need-kde 3.3

DESCRIPTION="kcpufreq is a KDE 3.x panel applet that displays the current CPU frequency."
HOMEPAGE="http://www.wastl.net/projects_html"
SRC_URI="http://www.wastl.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"

IUSE="cpufreq"
SLOT="0"

DEPEND="cpufreq? (sys-power/cpufrequtils)"
RESTRICT="mirror $RESTRICT"
S=${WORKDIR}/${PN}
src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/kcpufreq_scsi.patch
}
