# Copyright 2012-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

LUA_COMPAT=( lua5-4 luajit )
inherit cmake multiprocessing lua-single

_COMMIT="76dd7070776040985871557fb27f8df3606c75d8"
_LUA_COMMIT="7be6974b6d81c116bba39f6707dc640f6636fa4e"
_OCTAGRAM_COMMIT="bd12863f45fbbd5c7db06d5ec8be8987b10253bf"
_PROTO_COMMIT="657a923cd4c333e681dc943e6894e6f6d42d25b4"
_PREDICT_COMMIT="591c80a8d0481be99c44d008c15acd55074d8c68"

DESCRIPTION="RIME (Rime Input Method Engine) core library"
HOMEPAGE="https://rime.im/ https://github.com/rime/librime"
SRC_URI="
	https://github.com/rime/librime/archive/${_COMMIT}.tar.gz -> ${P}.tar.gz
	lua? ( https://github.com/hchunhui/librime-lua/archive/${_LUA_COMMIT}.tar.gz -> ${P}-lua.tar.gz )
	octagram? ( https://github.com/lotem/librime-octagram/archive/${_OCTAGRAM_COMMIT}.tar.gz -> ${P}-octagram.tar.gz )
	proto? ( https://github.com/lotem/librime-proto/archive/${_PROTO_COMMIT}.tar.gz -> ${P}-proto.tar.gz )
	predict? ( https://github.com/lotem/librime-predict/archive/${_PREDICT_COMMIT}.tar.gz -> ${P}-predict.tar.gz )
"
S=${WORKDIR}/${PN}-${PV}

LICENSE="BSD BSD-2 Boost-1.0 MIT"
SLOT="0/1-${PV}"
KEYWORDS="~amd64"
IUSE="
	+lua
	octagram
	+proto
	predict
	debug
	test
"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/glog:=
	>=dev-libs/boost-1.74:=
	app-i18n/opencc:0=
	dev-cpp/yaml-cpp:0=
	dev-libs/leveldb:0=
	dev-libs/marisa:0=
	proto? ( dev-libs/capnproto )
	lua? ( !app-i18n/librime-lua )
"
DEPEND="${RDEPEND}
	test? ( dev-cpp/gtest )
	lua? ( ${LUA_DEPS} )
"

BDEPEND="
	dev-build/cmake
	app-alternatives/ninja
"

DOCS=(CHANGELOG.md README.md)

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
	cmake_src_prepare
}

src_configure() {
	local -x CXXFLAGS="${CXXFLAGS}"

	# for glog
	if use debug; then
		CXXFLAGS+=" -DDCHECK_ALWAYS_ON"
		CMAKE_BUILD_TYPE=Debug
	else
		CXXFLAGS+=" -DNDEBUG"
	fi

	local mycmakeargs=(
		-DBUILD_TEST=$(usex test ON OFF)
		-DCMAKE_BUILD_PARALLEL_LEVEL=$(makeopts_jobs)
		-DENABLE_EXTERNAL_PLUGINS=ON
		-DINSTALL_PRIVATE_HEADERS=ON
	)

	cmake_src_configure
}

src_compile() {
	emake release
}

src_install() {
	emake DESTDIR="${D}" install
}
