# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python2_7 )
#PYTHON_MODNAME="libbe"

inherit eutils distutils-r1 bash-completion-r1

if [[ "${PV}" == "9999" ]] ; then
	inherit git-2
	EGIT_BRANCH="master"
	EGIT_REPO_URI="git://gitorious.org/be/be.git"
	SRC_URI=""
else
	SRC_URI="http://download.bugseverywhere.org/releases/${P}.tar.gz"
fi

DESCRIPTION="Bugs Everywere distributed bug tracker"
HOMEPAGE="http://bugseverywhere.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
IUSE="bash-completion doc zsh-completion"

RDEPEND="$PYTHON_DEPS
	dev-python/cherrypy
	dev-python/jinja
	dev-python/pyyaml
	bash-completion? ( app-shells/bash-completion )
	zsh-completion? ( app-shells/zsh-completion )"
DEPEND="${RDEPEND}
	dev-vcs/git
	dev-python/docutils
	doc? (
		dev-python/numpydoc
		dev-util/scons
	)"
# dev-python/numpydoc is in the science overlay
#   http://overlays.gentoo.org/proj/science/wiki/en

src_unpack() {
	if [[ "${PV}" == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack "${A}"
	fi
	cd "${S}"
}

src_prepare() {
	distutils-r1_src_prepare
}

src_compile() {
	make libbe/_version.py || die "_version.py generation failed"
	emake RST2MAN="${EROOT}usr/bin/rst2man.py" doc/man/be.1 \
	  || die "be.1 generation failed"
	if use doc ; then
		make -C doc html
	fi
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	dodoc AUTHORS NEWS README || die "dodoc failed"
	if [[ "${PV}" != "9999" ]] ; then
		dodoc ChangeLog || die "dodoc failed"
	fi
	if use doc ; then
		dohtml -r doc/.build/html/*
	fi
	if use bash-completion ; then
		newbashcomp misc/completion/be.bash be
	fi
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions/
		newins misc/completion/be.zsh _be
	fi
}
