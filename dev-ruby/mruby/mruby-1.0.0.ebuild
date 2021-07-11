# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="mruby is the lightweight implementation of the Ruby language complying to (part of) the ISO standard."
HOMEPAGE="https://github.com/mruby/mruby"
SRC_URI="https://github.com/mruby/mruby/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
sys-devel/bison
dev-lang/ruby"

src_install() {
	dobin bin/{mirb,mrbc,mruby}
	dolib.a build/host/lib/{libmruby.a,libmruby_core.a}

	insinto /usr/include/
	doins -r include/{mrbconf.h,mruby,mruby.h}
}
