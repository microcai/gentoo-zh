# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

CHECKREQS_DISK_BUILD="27000M"
CHECKREQS_DISK_USR="512M"
CHECKREQS_MEMORY="4092M"

inherit check-reqs multiprocessing pax-utils python-any-r1 systemd toolchain-funcs

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"
LICENSE="Apache-2.0 SSPL-1"
SLOT="rapid"
KEYWORDS="~amd64"
CPU_FLAGS="cpu_flags_x86_avx"
IUSE="debug kerberos lto mongosh ssl gold +tools ocsp-stapling server-js tcmalloc tcmalloc-experimental"
IUSE+=" free-mon http-client runtime-hardening experimental-optimization experimental-runtime-hardening"
IUSE+=" ${CPU_FLAGS}"
SRC_URI="https://github.com/mongodb/mongo/archive/r${PV}.tar.gz"

REQUIRED_USE="
	experimental-runtime-hardening? ( runtime-hardening )
	tcmalloc? ( !tcmalloc-experimental )
"

# https://github.com/mongodb/mongo/wiki/Test-The-Mongodb-Server
# resmoke needs python packages not yet present in Gentoo
RESTRICT="test"

RDEPEND="acct-group/mongodb
	acct-user/mongodb
	>=app-arch/snappy-1.1.3:=
	>=dev-cpp/yaml-cpp-0.6.2:=
	>=dev-libs/boost-1.70:=[threads(+),nls]
	>=dev-libs/libpcre-8.42[cxx]
	app-arch/zstd:=
	dev-libs/snowball-stemmer:=
	net-libs/libpcap
	>=sys-libs/zlib-1.2.11:=
	kerberos? ( dev-libs/cyrus-sasl[kerberos] )
	http-client? ( net-misc/curl )
	gold? ( sys-devel/binutils:=[gold] )
	ssl? (
		>=dev-libs/openssl-1.0.1g:0=
	)
"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		>=dev-util/scons-4.3.0[${PYTHON_USEDEP}]
		dev-python/cheetah3[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
	')
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	debug? ( dev-util/valgrind )
	!dev-db/mongodb:0
"

PDEPEND="
	mongosh? ( app-admin/mongosh-bin )
	tools? ( >=app-admin/mongo-tools-100 )
"

PATCHES=( ${FILESDIR}/mongodb-5.0.2-skip-reqs-check.patch )

python_check_deps() {
	has_version ">=dev-util/scons-4.3.0[${PYTHON_USEDEP}]" &&
	has_version "dev-python/cheetah3[${PYTHON_USEDEP}]" &&
	has_version "dev-python/psutil[${PYTHON_USEDEP}]" &&
	has_version "dev-python/pyyaml[${PYTHON_USEDEP}]" &&
	has_version "dev-python/packaging[${PYTHON_USEDEP}]"
}

S=${WORKDIR}/mongo-r${PV}

pkg_pretend() {
	if ! use cpu_flags_x86_avx; then
		eerror "MongoDB ${PV} requires use of the AVX instruction set"
		eerror "https://docs.mongodb.com/v5.0/administration/production-notes/"
		die "MongoDB requires AVX"
	fi

	check-reqs_pkg_pretend
}

src_prepare() {
	default
}

src_configure() {
	scons_opts=(
		AR="ar"
		CC="gcc"
		CXX="g++"
		CCFLAGS="-march=native -pipe -DBOOST_LOG_DYN_LINK ${CCFLAGS}"
		MONGO_VERSION=${PV}

		--jobs=$(makeopts_jobs)
		--release
		--disable-warnings-as-errors
		--use-system-boost
		--use-system-pcre
		--use-system-snappy
		--use-system-stemmer
		--use-system-yaml
		--use-system-zlib
		--use-system-zstd
		--use-diagnostic-latches=on
		--use-hardware-crc32=on
		--wiredtiger=on
		--link-model=auto
		--opt=on
		--use-libunwind=auto
		--build-tools=next
		--cxx-std=20
		--visibility-support=on
		--enable-usdt-probes=off
	)

	if use ssl; then
		scons_opts+=( --ssl=on )
	else
		scons_opts+=( --ssl=off )
	fi

	if use free-mon; then
		scons_opts+=( --enable-free-mon=on )
	else
		scons_opts+=( --enable-free-mon=off )
	fi

	if use gold; then
		scons_opts+=( --linker=gold )
	else
		scons_opts+=( --linker=bfd )
	fi

	if use http-client; then
		scons_opts+=( --enable-http-client=on )
	else
		scons_opts+=( --enable-http-client=off )
	fi

	if use ocsp-stapling; then
		scons_opts+=( --ocsp-stapling=on )
	else
		scons_opts+=( --ocsp-stapling=off )
	fi

	if use kerberos; then
		scons_opts+=( --use-sasl-client )
	fi

	if use tcmalloc; then
		scons_opts+=( --allocator=tcmalloc )
	elif use tcmalloc-experimental; then
		scons_opts+=( --allocator=tcmalloc-experimental )
	else
		scons_opts+=( --allocator=system )
	fi

	if use server-js; then
		scons_opts+=(
			--js-engine=mozjs
			--server-js=on
			)
	else
		scons_opts+=(
			--js-engine=none
			--server-js=off
		)
	fi

	if use lto; then
		scons_opts+=( --lto=on )
	else
		scons_opts+=( --lto=off )
	fi

	if use experimental-optimization; then
		scons_opts+=(
			--experimental-optimization="*"
			--experimental-optimization="-sandybridge"
		)
	fi

	if use runtime-hardening; then
		scons_opts+=( --runtime-hardening=on )
		if use experimental-runtime-hardening; then
			scons_opts+=( --experimental-runtime-hardening="*" )
		fi
	else
		scons_opts+=( --runtime-hardening=off )
	fi

	if use debug; then
		scons_opts+=( --dbg=on )
	else
		scons_opts+=( --dbg=off )
	fi

	default
}

src_compile() {
	PREFIX="${EPREFIX}/usr" ./buildscripts/scons.py "${scons_opts[@]}" install-core

	$(tc-getSTRIP) "--strip-unneeded" "${S}/build/install/bin/mongo"
	$(tc-getSTRIP) "--strip-unneeded" "${S}/build/install/bin/mongod"
	$(tc-getSTRIP) "--strip-unneeded" "${S}/build/install/bin/mongos"
}

src_install() {
	dobin build/install/bin/{mongo,mongod,mongos}

	doman debian/mongo*.1
	dodoc build/install/README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd-r3" ${PN}
	newconfd "${FILESDIR}/${PN}.confd-r3" ${PN}
	newinitd "${FILESDIR}/mongos.initd-r3" mongos
	newconfd "${FILESDIR}/mongos.confd-r3" mongos

	insinto /etc
	newins "${FILESDIR}/${PN}.conf-r3" ${PN}.conf
	newins "${FILESDIR}/mongos.conf-r2" mongos.conf

	systemd_dounit "${FILESDIR}/${PN}.service"

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	# see bug #526114
	pax-mark emr "${ED}"/usr/bin/{mongo,mongod,mongos}

	local x
	for x in /var/{lib,log}/${PN}; do
		diropts -m0750 -o mongodb -g mongodb
		keepdir "${x}"
	done
}

pkg_postinst() {
	ewarn "Make sure to read the release notes and follow the upgrade process:"
	ewarn "  https://docs.mongodb.com/manual/release-notes/$(ver_cut 1-2)/"
	ewarn "  https://docs.mongodb.com/manual/release-notes/$(ver_cut 1-2)/#upgrade-procedures"
}
