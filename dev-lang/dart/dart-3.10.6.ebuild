# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {20..21} )
LLVM_OPTIONAL=1

inherit unpacker ninja-utils llvm-r1 toolchain-funcs

DESCRIPTION="The Dart SDK"
HOMEPAGE="https://dart.dev https://github.com/dart-lang/sdk"
# repack sdk by "abuild snapshot"
# https://github.com/alpinelinux/aports/blob/master/testing/dart/APKBUILD
# cookbook: https://lingchengling.feishu.cn/docx/VIkqdR04koXb1exOqmbcSz2DnZe
SRC_URI="
	https://github.com/gentoo-zh-drafts/dart-sdk-repack/releases/download/${PV}/dart-sdk-${PV}.tar.zst
	https://storage.googleapis.com/dart-archive/channels/stable/release/${PV}/sdk/dartsdk-linux-x64-release.zip
		-> dartsdk-${PV}-amd64.zip
"

S="${WORKDIR}/dart-sdk-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="clang"
REQUIRED_USE="clang? ( ${LLVM_REQUIRED_USE} )"

BDEPEND="
	app-arch/unzip
	dev-build/gn
	dev-build/ninja
	clang? (
		$(llvm_gen_dep '
			llvm-core/clang:${LLVM_SLOT}
			llvm-core/lld:${LLVM_SLOT}
		')
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-3.10.2-fix_toolchain_prefix.patch"
	"${FILESDIR}/${PN}-3.10.2-use_system_clang.patch"
	"${FILESDIR}/${PN}-3.10.2-use_lld_when_using_clang.patch"
	"${FILESDIR}/${PN}-3.10.2-custom_flags.patch"
)

src_prepare() {
	# https://github.com/dart-lang/sdk/issues/52295
	# needed by build.ninja.stamp
	mkdir -pv .git/logs
	touch .git/logs/HEAD

	ln -sfv "${WORKDIR}"/dart-sdk tools/sdks/dart-sdk

	# needed by tools/build.py
	# ln -sfv /usr/bin/gn buildtools/gn
	# mkdir -p buildtools/ninja
	# ln -sfv /usr/bin/ninja buildtools/ninja/ninja

	python3 tools/generate_package_config.py
	python3 tools/generate_sdk_version_file.py

	default
}

src_configure() {
	local mygnargs=()
	mygnargs+=( 'target_cpu="x64"' )
	mygnargs+=( "is_clang=$(usex clang true false)" )
	mygnargs+=( 'is_debug=false' )
	mygnargs+=( 'is_release=true' )
	mygnargs+=( 'dart_platform_sdk=false' )
	mygnargs+=( 'verify_sdk_hash=false' )
	use clang && mygnargs+=( "clang_toolchain_dir=\"$(get_llvm_prefix)/bin\"" )
	gn gen --args="${mygnargs[*]}" out/Release
}

src_compile() {
	# fix can't find cc1plus
	export PATH=/usr/libexec/gcc/${CHOST}/$(gcc-major-version)/:$PATH
	local myninjaargs=""
	myninjaargs+=" runtime"
	myninjaargs+=" create_sdk"
	eninja ${myninjaargs} -C out/Release
}

src_install() {
	insinto /usr/lib/dart
	doins -r out/Release/dart-sdk/*

	fperms +x /usr/lib/dart/bin/dart
	fperms +x /usr/lib/dart/bin/dartaotruntime
	fperms +x /usr/lib/dart/bin/utils/gen_snapshot
	fperms +x /usr/lib/dart/bin/utils/wasm-opt

	dosym ../lib/dart/bin/dart /usr/bin/dart
	dosym ../lib/dart/bin/dartaotruntime /usr/bin/dartaotruntime
}
