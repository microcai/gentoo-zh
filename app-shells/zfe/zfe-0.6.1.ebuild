# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small unix terminal file explorer"
HOMEPAGE="https://github.com/BrookJeynes/zfe"

declare -g -r -A ZBS_DEPENDENCIES=(
    [vaxis-1220d587525255e734670ae74f38cb09d75df936c7889b07a6eab739c066dc736f85.tar.gz]='https://github.com/rockorager/libvaxis/archive/77f5795892b08cd64ad6a103f0c53a7d1db50b18.tar.gz'
    [fuzzig-122019f077d09686b1ec47928ca2b4bf264422f3a27afc5b49dafb0129a4ceca0d01.tar.gz]='https://github.com/fjebaker/fuzzig/archive/0fd156d5097365151e85a85eef9d8cf0eebe7b00.tar.gz'
    [zuid-1220e05a3f459c0adbf2b09b4764838833e3e716a712852aec6ef1636f4d8e9f646e.tar.gz]='https://github.com/KeithBrown39423/zuid/archive/49e5980ba83f7d9ae967fa7ce4d54384c1c0f82b.tar.gz'
    [zigimg-1220dd654ef941fc76fd96f9ec6adadf83f69b9887a0d3f4ee5ac0a1a3e11be35cf5.tar.gz]='https://github.com/zigimg/zigimg/archive/3a667bdb3d7f0955a5a51c8468eac83210c1439e.tar.gz'
    [zg-122055beff332830a391e9895c044d33b15ea21063779557024b46169fb1984c6e40.tar.gz]='https://codeberg.org/atman/zg/archive/v0.13.2.tar.gz'
)

ZIG_SLOT="0.13"
inherit zig

SRC_URI="
	https://github.com/BrookJeynes/zfe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

src_configure() {
	local my_zbs_args=(
		--release=safe
	)

	zig_src_configure
}
