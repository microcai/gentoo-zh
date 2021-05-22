#!/bin/bash
#

set -e

ctime="$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S %Z')"

pushd gentoo-zh
../relation-of-ebuilds-in-overlay-r1-for-gentoo-zh.sh "-t${ctime}" >../relation.md
popd

set -x
_gitdiff="$(git diff relation.md | egrep '^@@.*@@$' | tr '\n' ' ')"
if [[ ${_gitdiff%% } != '@@ -1,6 +1,6 @@' ]]; then
  git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git config --local user.name "github-actions[bot]"
  git add .
  git commit -m "${ctime} (updated)"
  echo "::set-output name=state::changed"
else
  echo "::set-output name=state::unchanged"
fi
