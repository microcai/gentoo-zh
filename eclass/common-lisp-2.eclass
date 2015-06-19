# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
# Maintained by the Gentoo Common Lisp project
# irc: #gentoo-lisp, herd: <common-lisp@gentoo.org>, list: <gentoo-lisp@gentoo.org>
#
# This eclass supports the installation of Common Lisp libraries
#
# Public functions:
#
# common-lisp-install path [<other_paths>...]
#   recursively install sources
#
# common-lisp-symlink-asdf [<paths>...]
#   create symlinks in $CLSYSTEMROOT to asdf files
#
# common-lisp-export-impl-args lisp-implementation
#   export a few variables containing the switches necessary
#   to make the CL implementation perform basic functions:
#   * CL_NORC: don't load initfiles
#   * CL_LOAD: load a certain file
#   * CL_EVAL: eval a certain expression at startup
#

inherit eutils

# CL packages in the overlay don't have their tarballs on the mirrors
# so it's useless to mirror them
RESTRICT="mirror"

CLSOURCEROOT="${ROOT%/}"/usr/share/common-lisp/source
CLSYSTEMROOT="${ROOT%/}"/usr/share/common-lisp/systems

# Sources will be installed into ${CLSOURCEROOT}/${CLPACKAGE}/
# Any asdf files will be symlinked in ${CLSYSTEMROOT}/${CLSYSTEM} as they may be
# in an arbitrarily deeply nested directory under ${CLSOURCEROOT}/${CLPACKAGE}/

# To override, set these after inheriting this eclass
CLPACKAGE="${PN}"
CLSYSTEMS="${PN}"

RDEPEND="virtual/commonlisp"

EXPORT_FUNCTIONS src_install

absolute-path-p() {
	[[ $# = 1 ]] || die "${FUNCNAME[0]} must receive one argument"
	[[ ${1} = /* ]]
}

common-lisp-install-source() {
	[[ $# = 2 ]] || die "${FUNCNAME[0]} must receive exactly two arguments"

	local source="${1}"
	local target="${CLSOURCEROOT}/${CLPACKAGE}/${2}"
	insinto "${target}"
	doins -r "${source}" || die "Failed to install ${source} into $(dirname "${target}")"
}

common-lisp-install() {
	[[ $# = 0 ]] && die "${FUNCNAME[0]} must receive at least one argument"
	for path in "$@"; do
		if absolute-path-p "${path}" ; then
			die "Cannot install files with absolute path: ${path}"
		fi
		common-lisp-install-source "${path}" "$(dirname "${path}")"
	done
}

common-lisp-install-single-system() {
	[[ $# != 1 ]] && die "${FUNCNAME[0]} must receive exactly one argument"

	local file="${CLSOURCEROOT%/}/${CLPACKAGE}/${1}.asd"
	[[ -f "${D}"/${file} ]] || die "${D}/${file} does not exist"
	dosym "${file}" "${CLSYSTEMROOT%/}/$(basename ${file})"
}

# Symlink asdf files
# if no arguments received, default to the contents of ${CLSYSTEMS}
common-lisp-symlink-asdf() {
	dodir "${CLSYSTEMROOT}"

	[[ $# = 0 ]] && set - ${CLSYSTEMS}
	for package in "$@" ; do
		common-lisp-install-single-system "${package}"
	done
}

common-lisp-system-symlink() {
	die "common-lisp-system-symlink() has been renamed to common-lisp-symlink-asdf()"
}

common-lisp-2_src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	for i in README HEADER TODO CHANGELOG ChangeLog CHANGES BUGS CONTRIBUTORS *NEWS ; do
		[[ -f ${i} ]] && dodoc ${i}
	done
}

common-lisp-export-impl-args() {
	if [[ $# != 1 ]]; then
		eerror "Usage: ${0} lisp-implementation"
		die "${0}: wrong number of arguments: $#"
	fi
	case ${1} in
		clisp)
			CL_NORC="-norc"
			CL_LOAD="-i"
			CL_EVAL="-x"
			;;
		clozure|ccl|openmcl)
			CL_NORC="--no-init"
			CL_LOAD="--load"
			CL_EVAL="--eval"
			;;
		cmucl)
			CL_NORC="-nositeinit -noinit"
			CL_LOAD="-load"
			CL_EVAL="-eval"
			;;
		ecl)
			CL_NORC="-norc"
			CL_LOAD="-load"
			CL_EVAL="-eval"
			;;
		sbcl)
			CL_NORC="--sysinit /dev/null --userinit /dev/null"
			CL_LOAD="--load"
			CL_EVAL="--eval"
			;;
		*)
			die ${1} is not supported by ${0}
			;;
	esac
	export CL_NORC CL_LOAD CL_EVAL
}
