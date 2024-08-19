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
	local wget_args=""
	if [ x${WGET_REFERER} != x"" ];then
		wget_args+=" --referer ${WGET_REFERER} "
	fi
	if [ x${WGET_USER_AGENT} != x"" ]; then
		wget_args+="--user-agent ${WGET_USER_AGENT} "
	fi
	/usr/bin/wget -t 5 ${wget_args} --passive-ftp -P ${DISTDIR} ${WGET_SRC_URI}
}

fi
