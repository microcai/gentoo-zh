#!/bin/bash
#
# tested under bash 5.0.18

# AUTHOR: bekcpear <i@bitbili.net>
# LICENSE: GPL v2
#
# TODO: rewrite by an efficient language

export LC_ALL=C
set -e

if [[ ${1} =~ ^-t ]]; then
  ctime="${1#-t}"
  shift
fi

# @FUNCTION: _log
# @USAGE: [-d|-i|-w|-e] <message>
# @INTERNAL
# @DESCRIPTION:
# Echo messages with a unified format.
#  '-d' means it's an DEBUG level msg;
#  '-i' means it's an  INFO level msg;
#  '-w' means it's an  WARN level msg;
#  '-e' means it's an ERROR level msg;
# Msg will be printed to the standard output normally
# when this function is called without any option.
function _log() {
  local lv="normal"
  local color='\e[36m'
  local reset='\e[0m'
  local outfd='&1'
  if [[ ${1} =~ ^- ]] && [[ -n ${2} ]]; then
    case ${1} in
      -d)
        lv="DEBUG"
        color='\e[0m'
        outfd='&1'
        ;;
      -i)
        lv=" INFO"
        color='\e[0m'
        outfd='&1'
        ;;
      -w)
        lv=" WARN"
        color='\e[33m'
        outfd='&2'
        ;;
      -e)
        lv="ERROR"
        color='\e[31m'
        outfd='&2'
        ;;
      *)
        echo "UNRECOGNIZED OPTION OF _log FUNCTION!" >&2
        exit 1
        ;;
    esac
    shift
  fi
  local prefix=""
  local msg="${@}"
  if [[ ${lv} != normal ]]; then
    prefix="[$(date '+%Y-%m-%d %H:%M:%S') ${lv}] "
  fi
  eval ">${outfd} echo -e '${color}${prefix}${msg//\'/\'\\\'\'}${reset}'"
}

function _fatal() {
  _log -e "${@}"
  exit 1
}

# 1: last recorded val (date +%s%N)
function _last_duration() {
  echo "scale=9; ( $(date +%s%N) - ${1} ) / 1000000000" | bc
}
# (omit for last called time)
function _last_duration_echo() {
  #if [[ -z ${_LAST_DURATION_TIME} ]]; then
  #  _LAST_DURATION_TIME=$(date +%s%N)
  #fi
  echo ${1:-L}:$(_last_duration ${2:-${_LAST_DURATION_TIME}}) >&2
  _LAST_DURATION_TIME=$(date +%s%N)
}

[[ -f profiles/repo_name ]] || _fatal "should be run under a portage repository."

__received_sig=
__errfn="/tmp/$(basename ${0%.*})-$(uuidgen).err"
trap 'if [[ ${__received_sig} != INT ]]; then
  set >${__errfn}
  _log -e "Environment vars have been add to ${__errfn}" >&2
fi' ERR
trap "__received_sig=INT; exit 1" SIGINT

REPONAME=$(< profiles/repo_name)
_log -w "Reponame: ${REPONAME}"

BACKUP_FILE_PREFIX="roe_hczAbkvN"
BACKUP_FILE="/tmp/${BACKUP_FILE_PREFIX}_${REPONAME}_$(date +%Y%m%d%H).info.tmp"
declare -i i=0
while [[ -e ${BACKUP_FILE} || -L ${BACKUP_FILE} ]]; do
  BACKUP_FILE="${BACKUP_FILE%.[[:digit:]]*}.${i}"
  i+=1
done
declare -i PKGINDEX=0
declare -a PKGS
declare -A PKGSR

_collect_start=$(date +%s%N)
if [[ -z ${1} ]]; then
  _log -w "Collecting information ..."
  _pkgdirs=($(ls --file-type -1d */* | egrep '/$' | sort -d))
  for (( i = 0; i < ${#_pkgdirs[@]}; ++i )); do
    _pkgdirs[i]=${_pkgdirs[i]%/}
    _ebuilds=($(find ${_pkgdirs[i]} -maxdepth 1 -name '*.ebuild' -printf '%f\n' | sort -d))
    if [[ ${#_ebuilds[@]} -le 0 ]]; then
      _log -w "No ebuild file under ${_pkgdirs[i]}."
    else
      for (( j = 0; j < ${#_ebuilds[@]}; ++j )); do
        __ebuild_path="${_pkgdirs[i]}/${_ebuilds[j]}"
        if [[ ! -e ${__ebuild_path} ]]; then
          _log -w "${__ebuild_path} not exist."
          continue
        fi
        __zRZI_j=${j}
        __zRZI_pkgi=${PKGINDEX}
        __zRZI_cate="${_pkgdirs[i]%/*}"
        __zRZI_name="${_pkgdirs[i]#*/}"
        __zRZI_version=${_ebuilds[j]%\.ebuild}
        __zRZI_version=${__zRZI_version#${__zRZI_name}-}
        declare -i _ret=0
        _declare_array=$(
          set -e
          DESCRIPTION=
          HOMEPAGE=
          DEPEND=
          BDEPEND=
          RDEPEND=
          declare -r __zRZI_j __zRZI_pkgi __zRZI_cate __zRZI_name __zRZI_version
          . ./${__ebuild_path} 2>/dev/null || true
          _desc=$(sed -E '/^[[:space:]]*$/d;s/\$/\\\$/g;s/^[[:space:]]+//;s/[[:space:]]+$//;s/\"/\\\"/g' <<<"${DESCRIPTION}")
          _homepage=( ${HOMEPAGE} )
          _sed_pattern="s/\[[^]]*\]//g;\
                        s/[^[:space:]]*\?/ /g;\
                        s/\![^[:space:]]+([[:space:]]|$)/ /g;\
                        s/[()^&|><=~'\"]|-[[:digit:]][^[:space:]]*|:[^[:space:]]*//g"
           _d=$(sed -E "${_sed_pattern}"  <<<"${DEPEND}")
          _bd=$(sed -E "${_sed_pattern}" <<<"${BDEPEND}")
          _rd=$(sed -E "${_sed_pattern}" <<<"${RDEPEND}")
          echo "declare -A PKG_${__zRZI_pkgi}_${__zRZI_j}=(
            [CATE]=\"${__zRZI_cate}\"
            [NAME]=\"${__zRZI_name}\"
            [VERSION]=\"${__zRZI_version}\"
            [DESCRIPTION]=\"${_desc}\"
            [HOMEPAGE]=\"${_homepage[0]}\"
            [D]=\"${_d}\"
            [BD]=\"${_bd}\"
            [RD]=\"${_rd}\"
          )"
        ) || _ret=$?
        if [[ ${_ret} != 0 ]]; then
          _log -e "Something error when parsing ${__ebuild_path}"
          _declare_array="declare -A PKG_${__zRZI_pkgi}_${__zRZI_j}=(
            [CATE]=\"${__zRZI_cate}\"
            [NAME]=\"${__zRZI_name}\"
            [VERSION]=\"${__zRZI_version}\"
            [DESCRIPTION]=\"[Something error when parsing.]\"
            [HOMEPAGE]=\"#\"
            [D]=\"\"
            [BD]=\"\"
            [RD]=\"\"
          )"
        fi
        #backup temporary database
        echo "${_declare_array}" >>${BACKUP_FILE}
        eval ${_declare_array}
        unset _declare_array #_version _desc _summary _homepage _d _bd _rd
      done
      eval "PKGS[${PKGINDEX}]=${_pkgdirs[i]}"
      eval "PKGSR[${_pkgdirs[i]}]=${PKGINDEX}"
      PKGINDEX+=1
    fi
    unset _ebuilds
  done
  unset _pkgdirs
  _log -w "<duration: $(_last_duration ${_collect_start})>"
  #backup temporary database
  declare -p PKGS >>${BACKUP_FILE}
  declare -p PKGSR >>${BACKUP_FILE}
  declare -p PKGINDEX >>${BACKUP_FILE}
  _log -w "Collected information has been backup to ${BACKUP_FILE}"
  BACKUP_FILE_REAL="${BACKUP_FILE}"
else
  _log -w "Reading information from ${1} ..."
  source "${1}"
  BACKUP_FILE_REAL="${1}"
fi

declare -i LINEINDEX=0

declare -a INDENT ROLE ORDER CHILDREN PARENT VERSIONS HOMEPAGE DESCRIPTION

# 1: index 2: force val
function _set_indent() {
  if [[ -n ${2} ]]; then
    eval "INDENT[${1}]=${2}"
  else
    eval ": \${INDENT[${1}]:=0}"
  fi
}

# 1: index 2: val
function _set_role() {
  if [[ -n ${2} ]]; then
    eval "ROLE[${1}]+=' \"${2}\"'"
  fi
}

# 1: index 2: force val
function _set_order() {
  if [[ -n ${2} ]]; then
    eval "ORDER[${1}]=${2}"
  elif [[ -z ${ORDER[${1}]} ]]; then
    LINEINDEX+=1
    eval ": \${ORDER[${1}]:=${LINEINDEX}}"
  fi
}

# 1: parent index 2: val(the child)
function _set_children() {
  local -i _parent=${1}
  local -i _child=${2}
  #set parent if it has none
  eval ": \${PARENT[${2}]:=${1}}"
  #add child
  eval "CHILDREN[${1}]+=' ${2}'"

  #reset parent when the already setted parent
  #(or has a parent) that is the same as the child's
  if [[ ${1} != ${PARENT[${2}]} ]]; then
    local -i _p=${PARENT[${2}]}
    local -a _pa
    function __reset_parent() {
      if [[ -n ${PARENT[${1}]} ]]; then
        _pa+=( ${PARENT[${1}]} )
        if [[ ${PARENT[${1}]} == ${_p} ]]; then
          eval "PARENT[${_child}]=${_parent}"
        else
          local -i _pam=$((${#_pa[@]} - 1))
          if [[ ${_pa[0]} == ${_pa[${_pam}]} ]]; then
            return
          fi
          __reset_parent ${PARENT[${1}]}
        fi
      fi
    }
    __reset_parent ${1}
  fi
}

# 1: parent index
function _reset_child_order_and_indent() {
  local -a _pa="${1}"
  function __reset_child_order_and_indent() {
    local _o=${ORDER[${1}]}
    local -i _i=$((${INDENT[${1}]} + 1))

    local -i _oo=0
    for child in ${CHILDREN[${1}]} ; do
      for __check_c in ${_pa[@]}; do
        if [[ ${child} == ${__check_c} ]]; then
          continue 2
        fi
      done
      _pa+=( "${child}" )
      if [[ ${child} != ${PARENT[${1}]} ]]; then
        _set_order ${child} "${_o}.${_oo}"
        _set_indent ${child} ${_i}
        __reset_child_order_and_indent ${child}
        _oo+=1
      fi
    done
  }
  __reset_child_order_and_indent "${@}"
}

# 1: index $@: versions...
function _set_vers() {
  local -i _i=${1}
  shift
  eval "VERSIONS[${_i}]='${@}'"
}

_log -w "Handle information ..."
declare -i _handle_offset=0
if [[ -n ${2} ]]; then
  _log -w "Reading handled data from ${2} ..."
  source ${2}
  _handle_offset=${_HANDLE_OFFSET_NEXT}
fi
__md5=$(md5sum ${BACKUP_FILE_REAL} | cut -d' ' -f1)
BACKUP_FILE_1="${BACKUP_FILE%%.*}_${__md5}.data.tmp"
i=0
while [[ -e ${BACKUP_FILE_1} || -L ${BACKUP_FILE_1} ]]; do
  BACKUP_FILE_1="${BACKUP_FILE_1%.[[:digit:]]*}.${i}"
  i+=1
done
_log -w "Handled data will be backup to ${BACKUP_FILE_1}"
_handle_start=$(date +%s%N)
for (( i = ${_handle_offset}; i < ${PKGINDEX}; i++ )); do
  _handle_start_each=$(date +%s%N)
  _name=${PKGS[i]}
  eval "HOMEPAGE[${i}]=\${PKG_${i}_0[HOMEPAGE]}"
  eval "DESCRIPTION[${i}]=\${PKG_${i}_0[DESCRIPTION]}"
  declare -a _deps _bdeps _rdeps _vers _pkg_deps
  for (( j = 0; j < 10; ++j )); do
    if eval "declare -p PKG_${i}_${j} >/dev/null 2>&1"; then
      eval "_deps+=( \${PKG_${i}_${j}[D]} )"
      eval "_bdeps+=( \${PKG_${i}_${j}[BD]} )"
      eval "_rdeps+=( \${PKG_${i}_${j}[RD]} )"
      eval "_vers+=( \${PKG_${i}_${j}[VERSION]} )"
    else
      break
    fi
  done

  _deps=($(echo "${_deps[@]}" | tr ' ' '\n' | sort -du | tr '\n' ' '))
  _bdeps=($(echo "${_bdeps[@]}" | tr ' ' '\n' | sort -du | tr '\n' ' '))
  _rdeps=($(echo "${_rdeps[@]}" | tr ' ' '\n' | sort -du | tr '\n' ' '))

  _set_vers ${i} "${_vers[@]}"
  _set_order ${i}
  _set_indent ${i}
  _set_role ${i}

  for __pkg in ${PKGS[@]}; do
    for __p in ${_deps[@]}; do
      if [[ ${__pkg} == ${__p} ]]; then
        idx=${PKGSR["${__pkg}"]}
        _set_role ${idx} ' D'
        _pkg_deps+=( ${idx} )
      fi
    done
    for __p in ${_bdeps[@]}; do
      if [[ ${__pkg} == ${__p} ]]; then
        idx=${PKGSR["${__pkg}"]}
        _set_role ${idx} 'BD'
        _pkg_deps+=( ${idx} )
      fi
    done
    for __p in ${_rdeps[@]}; do
      if [[ ${__pkg} == ${__p} ]]; then
        idx=${PKGSR["${__pkg}"]}
        _set_role ${idx} 'RD'
        _pkg_deps+=( ${idx} )
      fi
    done
  done

  #unified setting
  _pkg_deps=($(echo "${_pkg_deps[@]}" | tr ' ' '\n' | sort -nu | tr '\n' ' '))
  for (( k = 0; k < ${#_pkg_deps[@]}; ++k )); do
    idx=${_pkg_deps[k]}
    _set_order ${idx}
    _set_children ${i} ${idx}
    if [[ ${PARENT[idx]} == ${i} ]]; then
      #resort this line and it's children
      _reset_child_order_and_indent ${i}
    fi
  done

  declare -i _HANDLE_OFFSET_NEXT=$((${i} + 1))
  declare -p INDENT PARENT CHILDREN ROLE ORDER VERSIONS HOMEPAGE DESCRIPTION LINEINDEX _HANDLE_OFFSET_NEXT >"${BACKUP_FILE_1}" || _log -e "Corrupted backup file."

  unset _deps _bdeps _rdeps _vers _pkg_deps
done
echo -e "[${i}/${PKGINDEX}] handled. <total duration: $(_last_duration ${_handle_start})> (the last: ${_name})" >&2

_log -w "Handled information have been backup to ${BACKUP_FILE_1}"

#tidy roles
_log -w "Tidying roles ..."
for (( i = 0; i < ${#ROLE[@]}; ++i )); do
  eval "ROLE[${i}]=\$(sed 's/[[:space:]]\+\"/\\n\"/g' <<< '${ROLE[i]}' | sort -du | sed ':a;N;\$!ba;s/\\n/, /g;s/^\s*,\s*//')"
  eval "ROLE[${i}]='${ROLE[i]//\"/}'"
done

#sort LINE
declare -a LINE
# 1: val0 2: val1
# return 0 if val0 > val1
function _gt() {
  local -i val0=${1%%.*}
  local -i val1=${2%%.*}
  if [[ ${val0} -gt ${val1} ]]; then
    return 0
  elif [[ ${val0} -eq ${val1} ]]; then
    local -i _i=1
    function __more_gt() {
      local -a v0=( ${1//./ } )
      local -a v1=( ${2//./ } )
      if [[ ${v0[${_i}]:--1} -gt ${v1[${_i}]:--1} ]]; then
        return 0
      elif [[ ${v0[${_i}]:--1} -eq ${v1[${_i}]:--1} ]]; then
        if [[ ${_i} > 50 ]]; then
          _fatal "Too much comparations!"
        fi
        _i+=1
        __more_gt ${1} ${2}
      else
        return 1
      fi
    }
    local -i ret=0
    __more_gt ${1} ${2} || ret=1
    return ${ret}
  else
    return 1
  fi
}

# 1: left string explaining array; 2: right
function _sort_merge {
  local -a _l=( ${1} )
  local -a _r=( ${2} )
  local -i _llen=${#_l[@]}
  local -i _rlen=${#_r[@]}
  local -i i=0 j=0 index=0

  local -a _new
  while true; do
    if _gt ${_l[${i}]} ${_r[${j}]}; then
      _new[index]=${_r[${j}]}
      index+=1
      j+=1
      if [[ ${j} == ${_rlen} ]]; then
        eval "_new+=( \${_l[@]:${i}} )"
        break
      fi
    else
      _new[index]=${_l[${i}]}
      index+=1
      i+=1
      if [[ ${i} == ${llen} ]]; then
        eval "_new+=( \${_r[@]:${j}} )"
        break
      fi
    fi
  done
  echo "${_new[@]}"
}

# 1: string explaining array
_sort_latest=
function _sort_order {
  _sort_latest=$(date +%s%N)
  local -a _a=( ${1} )
  local -i _n=${#_a[@]}
  if [[ ${_n} -lt 2 ]]; then
    echo -n "${_a[@]}"
    _sort_latest=$(date +%s%N)
    return
  fi
  local -i _key=$(( ${_n} / 2 ))
  eval "local _left=\"\${_a[@]:0:${_key}}\""
  eval "local _right=\"\${_a[@]:${_key}}\""
  eval " _left=\$(_sort_order  '${_left}')"
  eval "_right=\$(_sort_order '${_right}')"
  eval "echo \$(_sort_merge '${_left}' '${_right}')"
}

#switch key & val of ORDER
declare -A ORDERR
_log -w "Making ORDERR ..."
for (( i = 0; i < ${#ORDER[@]}; ++i )); do
  eval "ORDERR[${ORDER[${i}]}]=${i}"
done
#sort ORDER
_log -w "Sorting ..."
_sort_start=$(date +%s%N)
eval "ORDER=( \$(_sort_order '${ORDER[@]}') )"
_log -w "<duration: $(_last_duration ${_sort_start})>"
#set LINE item
for (( i = 0; i < ${#ORDER[@]}; ++i )); do
  eval "LINE[${i}]=\${ORDERR[${ORDER[i]}]}"
done

#format print
_log -w "Format printing ..."
TITLE_NAME='Package name'
TITLE_VERSION='Version'
TITLE_ROLE='Role'
TITLE_HOMEPAGE='Homepage'
TITLE_DESCRIPTION='Description'
declare -i _longest_n=${#TITLE_NAME} \
           _longest_v=${#TITLE_VERSION} \
           _longest_r=${#TITLE_ROLE} \
           _longest_h=${#TITLE_HOMEPAGE} \
           _longest_d=${#TITLE_DESCRIPTION}
for idx in ${LINE[@]}; do
  _indent=''
  for (( i = 0; i < ${INDENT[idx]}; ++i )); do
    _indent+='  '
  done
  #set pkgname's indent
  eval "PKGS[${idx}]='${_indent}${PKGS[idx]}'"
  #check pkgname's longest length
  _t="${PKGS[idx]}"
  if [[ ${#_t} -gt ${_longest_n} ]]; then
    _longest_n=${#_t}
  fi
  #check rule's longest length
  _t="${ROLE[idx]}"
  if [[ ${#_t} -gt ${_longest_r} ]]; then
    _longest_r=${#_t}
  fi
  #check homepage's longest length
  _t="${HOMEPAGE[idx]}"
  if [[ ${#_t} -gt ${_longest_h} ]]; then
    _longest_h=${#_t}
  fi
  #check description's longest length
  _t="${DESCRIPTION[idx]}"
  if [[ ${#_t} -gt ${_longest_d} ]]; then
    _longest_d=${#_t}
  fi
done

#check version's longest length
for v in "${VERSIONS[@]}"; do
  _vers=( ${v} )
  for vv in ${_vers[@]}; do
    if [[ ${#vv} -gt ${_longest_v} ]]; then
      _longest_v=${#vv}
    fi
  done
done

PLACEHOLDER_NAME=''
HORIZONTAL_SEPARATOR_NAME=''
HORIZONTAL_SEPARATOR_D_NAME=''
_diff=$((${_longest_n} - ${#TITLE_NAME}))
for (( i = 0; i < ${_diff}; ++i )); do
  TITLE_NAME+=' '
done
for (( i = 0; i < ${_longest_n}; ++i )); do
  PLACEHOLDER_NAME+=' '
  HORIZONTAL_SEPARATOR_NAME+='-'
  HORIZONTAL_SEPARATOR_D_NAME+='='
done

PLACEHOLDER_VERSION=''
HORIZONTAL_SEPARATOR_VERSION=''
HORIZONTAL_SEPARATOR_D_VERSION=''
_diff=$((${_longest_v} - ${#TITLE_VERSION}))
for (( i = 0; i < ${_diff}; ++i )); do
  TITLE_VERSION+=' '
done
for (( i = 0; i < ${_longest_v}; ++i )); do
  PLACEHOLDER_VERSION+=' '
  HORIZONTAL_SEPARATOR_VERSION+='-'
  HORIZONTAL_SEPARATOR_D_VERSION+='='
done

PLACEHOLDER_ROLE=''
HORIZONTAL_SEPARATOR_ROLE=''
HORIZONTAL_SEPARATOR_D_ROLE=''
_diff=$((${_longest_r} - ${#TITLE_ROLE}))
for (( i = 0; i < ${_diff}; ++i )); do
  TITLE_ROLE+=' '
done
for (( i = 0; i < ${_longest_r}; ++i )); do
  PLACEHOLDER_ROLE+=' '
  HORIZONTAL_SEPARATOR_ROLE+='-'
  HORIZONTAL_SEPARATOR_D_ROLE+='='
done

PLACEHOLDER_HOMEPAGE=''
HORIZONTAL_SEPARATOR_HOMEPAGE=''
HORIZONTAL_SEPARATOR_D_HOMEPAGE=''
_diff=$((${_longest_h} - ${#TITLE_HOMEPAGE}))
for (( i = 0; i < ${_diff}; ++i )); do
  TITLE_HOMEPAGE+=' '
done
for (( i = 0; i < ${_longest_h}; ++i )); do
  PLACEHOLDER_HOMEPAGE+=' '
  HORIZONTAL_SEPARATOR_HOMEPAGE+='-'
  HORIZONTAL_SEPARATOR_D_HOMEPAGE+='='
done

PLACEHOLDER_DESCRIPTION=''
HORIZONTAL_SEPARATOR_DESCRIPTION='--------------------'
HORIZONTAL_SEPARATOR_D_DESCRIPTION='===================='
#_diff=$((${_longest_d} - ${#TITLE_DESCRIPTION}))
#for (( i = 0; i < ${_diff}; ++i )); do
#  TITLE_DESCRIPTION+=' '
#done
#for (( i = 0; i < ${_longest_d}; ++i )); do
#  PLACEHOLDER_DESCRIPTION+=' '
#  HORIZONTAL_SEPARATOR_DESCRIPTION+='-'
#  HORIZONTAL_SEPARATOR_D_DESCRIPTION+='='
#done

                 PATTERN_TITLE=' %s | %s | %s | %s | %s\n'
PATTERN_HORIZONTAL_SEPARATOR_D='=%s=|=%s=|=%s=|=%s=|%s\n'
  PATTERN_HORIZONTAL_SEPARATOR='-%s-|-%s-|-%s-|-%s-|%s\n'
                  PATTERN_DATA=' %s | %s | %s | %s |%s\n'
function _print_uniform() {
  eval "printf -- \"\${PATTERN_${1}}\" \"\${${1}_NAME}\" \"\${${1}_VERSION}\" \"\${${1}_ROLE}\" \"\${${1}_HOMEPAGE}\" \"\${${1}_DESCRIPTION}\""
}

printf -- "- Reponame: **\`${REPONAME}\`**\n\n"
printf -- "(The last generation time: ${ctime})\n\n"

printf '### Packages\n\n'
printf -- '```\n'
_print_uniform TITLE
_print_uniform HORIZONTAL_SEPARATOR_D

_is_the_first_line=1
for idx in ${LINE[@]}; do
  #unify pkgname's lenght
  _diff=$((${_longest_n} - ${#PKGS[idx]}))
  for (( j = 0; j < ${_diff}; ++j )); do
    eval "PKGS[${idx}]+=' '"
  done
  #unify version's lenght
  _vers=( $(echo "${VERSIONS[idx]}" | tr ' ' '\n' | sort -h | tr '\n' ' ') )
  for (( i = 0; i < ${#_vers[@]}; ++i)); do
    _diff=$((${_longest_v} - ${#_vers[i]}))
    for (( j = 0; j < ${_diff}; ++j )); do
      eval "_vers[${i}]+=' '"
    done
  done
  eval "VERSIONS[${idx}]='${_vers[@]}'"
  #unify rule's lenght
  _diff=$((${_longest_r} - ${#ROLE[idx]}))
  for (( j = 0; j < ${_diff}; ++j )); do
    eval "ROLE[${idx}]+=' '"
  done
  #unify homepage's lenght
  _diff=$((${_longest_h} - ${#HOMEPAGE[idx]}))
  for (( j = 0; j < ${_diff}; ++j )); do
    eval "HOMEPAGE[${idx}]+=' '"
  done

  if [[ ! ${PKGS[idx]} =~ ^[[:space:]] ]] && [[ ${_is_the_first_line} == 0 ]]; then
    _print_uniform HORIZONTAL_SEPARATOR
  fi
  _is_the_first_line=0
  _pkg_name_printed=0
  for (( i = 0; i < ${#_vers[@]}; ++i)); do
    if [[ ${_pkg_name_printed} == 0 ]]; then
      _pkg_name_printed=1
      if [[ ${DESCRIPTION[idx]} =~ [a-zA-Z#] ]]; then
        _desc=" ${DESCRIPTION[idx]}"
      fi
      printf -- "${PATTERN_DATA}" "${PKGS[idx]}" "${_vers[i]}" "${ROLE[idx]}" "${HOMEPAGE[idx]}" "${_desc}"
    else
      printf -- "${PATTERN_DATA}" "${PLACEHOLDER_NAME}" "${_vers[i]}" "${PLACEHOLDER_ROLE}" "${PLACEHOLDER_HOMEPAGE}" "${PLACEHOLDER_DESCRIPTION}"
    fi
  done
done

_print_uniform HORIZONTAL_SEPARATOR_D
printf -- '```'

#print some description
printf -- "
+ \` D\` means the classic dependencies (e.g.: libraries and headers)
+ \`BD\` means the build dependencies (e.g.: virtual/pkgconfig)
+ \`RD\` means runtime dependencies

_(All these dependencies are parsed literally.)_
"
