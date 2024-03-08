# Copyright 2012-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

LUA_COMPAT=( lua5-4 luajit )

inherit lua-single

DESCRIPTION="RIME (Rime Input Method Engine) core library"
HOMEPAGE="https://rime.im/ https://github.com/rime/librime"

_COMMIT="295cb2ab68f89ee9d3237c7d4b8033bda3f3b635"
_LUA_COMMIT="7f3eca2ce659fc2401b8acb52bd2182b433e12b1"
_OCTAGRAM_COMMIT="bd12863f45fbbd5c7db06d5ec8be8987b10253bf"
_PROTO_COMMIT="657a923cd4c333e681dc943e6894e6f6d42d25b4"
_PREDICT_COMMIT="72e4d717e56c6542569c88b317700b3471164c42"

SRC_URI="
	https://github.com/rime/librime/archive/${_COMMIT}.tar.gz -> ${P}.tar.gz
	lua? ( https://github.com/hchunhui/librime-lua/archive/${_LUA_COMMIT}.tar.gz -> ${P}-lua.tar.gz )
	octagram? ( https://github.com/lotem/librime-octagram/archive/${_OCTAGRAM_COMMIT}.tar.gz -> ${P}-octagram.tar.gz )
	proto? ( https://github.com/lotem/librime-proto/archive/${_PROTO_COMMIT}.tar.gz -> ${P}-proto.tar.gz )
	predict? ( https://github.com/lotem/librime-predict/archive/${_PREDICT_COMMIT}.tar.gz -> ${P}-predict.tar.gz )
"

S=${WORKDIR}/${PN}-${_COMMIT}

LICENSE="BSD BSD-2 Boost-1.0 MIT"
SLOT="0/1-${PV}"
KEYWORDS="~amd64 ~loong ~x86"
IUSE="
	+lua
	octagram
	+proto
	predict
"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"

RDEPEND="
	dev-cpp/glog:=
	dev-cpp/gtest
	>=dev-libs/boost-1.74:=
	app-i18n/opencc:0=
	dev-cpp/yaml-cpp:0=
	dev-libs/leveldb:0=
	dev-libs/marisa:0=
	proto? ( dev-libs/capnproto )
	lua? ( !app-i18n/librime-lua )
"
DEPEND="
	${RDEPEND}
	lua? ( ${LUA_DEPS} )
"
BDEPEND="
	dev-build/cmake
	app-alternatives/ninja
"

src_prepare() {
	default
	if use lua; then
		ln -sf "${WORKDIR}/${PN}-lua-${_LUA_COMMIT}" ./plugins/lua || die
	fi
	if use octagram; then
		ln -sf "${WORKDIR}/${PN}-octagram-${_OCTAGRAM_COMMIT}" ./plugins/octagram || die
	fi
	if use proto; then
		ln -sf "${WORKDIR}/${PN}-proto-${_PROTO_COMMIT}" ./plugins/proto || die
	fi
	if use predict; then
		ln -sf "${WORKDIR}/${PN}-predict-${_PREDICT_COMMIT}" ./plugins/predict || die
	fi
}

src_compile() {
	emake release
}

src_install() {
	emake DESTDIR="${D}" install
}
