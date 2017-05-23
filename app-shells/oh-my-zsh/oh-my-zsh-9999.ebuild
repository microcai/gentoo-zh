# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/robbyrussell/oh-my-zsh.git"

inherit git-2 eutils

DESCRIPTION="A community-driven framework for managing your zsh configuration. Includes 40+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, macports, etc), over 80 terminal themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. "
HOMEPAGE="https://github.com/robbyrussell/oh-my-zsh/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"


src_install() {
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r ${S}/*
	
	sed 's:$HOME/.oh-my-zsh:/usr/share/oh-my-zsh:g' ${D}/usr/share/${PN}/templates/zshrc.zsh-template
	dodir /etc/skel
	cp ${D}/usr/share/${PN}/templates/zshrc.zsh-template ${D}/etc/skel/.zshrc 
}