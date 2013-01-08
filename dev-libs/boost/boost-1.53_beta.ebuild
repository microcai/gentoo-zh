# $Header: $

EAPI=5

DEPEND="!<dev-libs/boost-1.53"
RDEPEND="${DEPEND}"

SLOT=0
SRC_URI="http://fysj.com/boost-1.53_beta.tar.xz"
IUSE="debug static-libs python mpi"

inherit eutils flag-o-matic multilib multiprocessing toolchain-funcs versionator


create_user-config.jam() {
        local compiler compiler_version compiler_executable

        if [[ ${CHOST} == *-darwin* ]]; then
                compiler="darwin"
                compiler_version="$(gcc-fullversion)"
                compiler_executable="$(tc-getCXX)"
        else
                compiler="gcc"
                compiler_version="$(gcc-version)"
                compiler_executable="$(tc-getCXX)"
        fi
        local mpi_configuration python_configuration

        if use mpi; then
                mpi_configuration="using mpi ;"
        fi

        if use python; then
                python_configuration="using python : : ${PYTHON} ;"
        fi

        cat > user-config.jam << __EOF__
using ${compiler} : ${compiler_version} : ${compiler_executable} : <cflags>"${CFLAGS}" <cxxflags>"${CXXFLAGS}" <linkflags>"${LDFLAGS}" ;
${mpi_configuration}
${python_configuration}
__EOF__
}



bootstrap() {
    create_user-config.jam
    ${S}/bootstrap.sh
}

src_configure() {
    OPTIONS="-j$(makeopts_jobs) -q -d+2 --user-config=${S}/user-config.jam"
    append-cxxflags -std=c++11 
    OPTIONS+=" link=$(usex static-libs shared,static shared) variant=$(usex debug debug,release release) --prefix=\"${D}/usr\" "
}

src_compile() {
   bootstrap
   create_user-config.jam
   ./b2 ${OPTIONS} || die "Building of boost failed"
   
}

src_install() {
    create_user-config.jam
    ./b2 ${OPTIONS} install --includedir="${D}usr/include" --libdir="${D}/usr/$(get_libdir)"
}

pkg_preinst() {
        # Yai for having symlinks that are nigh-impossible to remove without
        # resorting to dirty hacks like these. Removes lingering symlinks
        # from the slotted versions.
        local symlink
        for symlink in "${EROOT}usr/include/boost" "${EROOT}usr/share/boostbook"; do
                [[ -L ${symlink} ]] && rm -f "${symlink}"
        done
}
