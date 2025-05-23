#!/bin/bash

. /etc/init.d/functions.sh


OVERLAY=/var/lib/layman/gentoo-zh

einfo "clean thin Manifest"

remove() {
M=$1/Manifest
if [[ ! -e ${M} ]]; then
#	ewarn "$(basename $1) not exist"
	return
fi
einfo "$2: clean up: $(basename $1)"
sed -i -e '/ebuild/d' $M
sed -i -e '/metadata/d' $M
sed -i -e '/ChangeLog/d' $M

if [[ -d $1/files ]]; then
	for i in $(find $1/files -type f ); do
		V=${i##*\/}
		sed -i -e "/${V}/d" $M
	done 
fi

sed -i -e '/^$/d' $M
if [[ ! -s ${M} ]]; then
#	einfo "remove empty: $M"
	rm $M
fi
}

C=0
for i in $(find ${OVERLAY}  -maxdepth 2 -and -type d) ; do
	C=$((C+1))
	remove $i $C
done
