# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

EGIT_COMMIT="a6ced5a1d623afed17284fbaa395dd3a8b019a14"

DESCRIPTION="「八股文」語法 plugin for RIME"
HOMEPAGE="https://github.com/lotem/librime-octagram"

SRC_URI="https://github.com/lotem/librime-octagram/archive/$EGIT_COMMIT.tar.gz -> $P.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	>=app-i18n/librime-1.6:0=
	dev-libs/utfcpp
"
RDEPEND="$DEPEND"
BDEPEND="dev-libs/boost:0"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

IUSE="debug tools"

src_prepare() {
	sed -i "s/utf8.h/utf8cpp\/utf8.h/g" src/gram_encoding.cc src/octagram.cc || die

	sed -e "\$afind_package (glog REQUIRED)" \
		-e "\$atarget_link_libraries(build_grammar glog::glog rime)" \
		-i tools/CMakeLists.txt || die

	sed \
		-e "\$afind_package (glog REQUIRED)" \
		-e "1icmake_minimum_required(VERSION 3.0)\nproject(${PN})\n" \
		-e "s/ PARENT_SCOPE//" \
		-e "\$a\\\n" \
		-e "\$aadd_library(\${plugin_modules} MODULE \${plugin_objs})" \
		-e "\$aset_target_properties(\${plugin_modules} PROPERTIES PREFIX \"\")" \
		-e "\$atarget_link_libraries(\${plugin_modules} glog::glog rime \${plugin_deps})" \
		-e "\$ainstall(TARGETS \${plugin_modules} DESTINATION $(get_libdir)/rime-plugins)" \
		-i CMakeLists.txt || die

	cmake_src_prepare
}

src_configure(){
	if use debug; then
		CXXFLAGS+=" -DDCHECK_ALWAYS_ON"
	else
		CXXFLAGS+=" -DNDEBUG"
	fi

	cmake_src_configure
}

src_install() {
	if use tools ;then
		dobin "${S}_build/bin/build_grammar"
	fi

	cmake_src_install
}
