# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: wget.eclass
# @MAINTAINER:
# jinqiang zhang <peeweep@0x0.ee>
# @AUTHOR:
# jinqiang zhang <peeweep@0x0.ee>
# @SUPPORTED_EAPIS: 8
# @BLURB: test
# @DESCRIPTION:
# test

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_WGET_ECLASS} ]]; then
_WGET_ECLASS=1


wget_src_fetch(){
	if [ x${WGET_ARGS} == x"" ];then
		die "WGET_ARGS not set"
	fi
	/usr/bin/wget -t 5 ${WGET_ARGS} --passive-ftp -P ${DISTDIR} ${WGET_SRC_URI}
}

fi
