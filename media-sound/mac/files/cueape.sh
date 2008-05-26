#!/bin/bash

#cueape 0.1
#This script is intended to convert ape or flac + cue files to 
#ogg vorbis or mp3 files, setting the tags to the correct value,
#obtained from the cue file.
#REQUIREMENTS:
#	-Oggenc installed (it comes with vorbis-tools) if you want to encode into Ogg Vorbis.
#	-lame installed if you want to encode into mp3
#	-mac to decode ape files (Monkey's Audio)
#	-flac to decode flac files.

#IF YOU FIND A BUG OR HAVE A SUGGESTION COMMENTO OR SIMPLY WANT TO CONTACT ME PLEASE MAIL ME TO 
#rafadev_*@gmail.com  REMOVING THE "_*"
#This is done to prevent spamming 

#Copyright (C) 2006  Rafael Ponieman - Buenos Aires, Argentina

#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


#scripted by deX


case "$1" in
*.[aA][pP][eE] | *[fF][lL][aA][cC]	)
	if [ ! -f "$1" ] ; then
		echo "Input file $1 doesn't exist"
		exit 1
	fi
	if [ ! -f "$2" ]; then
		echo "Cue input file $2 doesn't exist"
		exit 1
	fi ;;
*	) 
	echo -ne "\033[1;31mError: invalid input parameters\n"
	echo -ne "\033[1;37m"
	echo -ne "Usage: cueape [input ape file] [input cue file] [parameters]\nParameters can be: -m for mp3 encoding or -o for ogg encoding.\n"
	echo 'for batch-conversion something like:'
	echo 'for i in `ls --color=never mozart*.ape`;do fn=`basename $i .ape`;dn=`pwd`;cueape.sh "$dn/$fn.ape" "$dn/$fn.cue" -m;mv "Output/" "$fn";rm "$dn/$fn/$fn.mp3" "$dn/$fn/$fn.wav" "$dn/$fn/$fn.cue";done'
	exit ;;
esac

#Testing parameters
if [ "$3" != "-m" ] && [ "$3" != "-o" ] ; then
	echo -en "\033[1;31mInvalid parameters\n"
	echo -en "\033[1;37m"
	echo -en "Usage: cueape [input ape file] [input cue file] [parameters]\nParameters can be: -m for mp3 encoding or -o for ogg encoding.\n"
	exit 1
fi

#Need help with this one, coudn't solve it. I need to know how to check if a 
#program actually exists and is accesible
#Checking for mac
#[ -f $(which 'maca' >> /dev/null) ] ||  { 
#	echo -en "\033[1;31mYou must have mac in your PATH.\033[1;37m\nPlease install Monkey's Audio Codec\nYou can get it from http://sourceforge.net/projects/mac-port/\n"
#}


#Saving the position so as to return afterwards 
olddir="$(pwd)"

#Going to target directory
cd "$(dirname "$1")"

#Checking for the output folder. If it's not there I create it
[ ! -d "Output" ] && mkdir -p "Output"
cp "$2" "Output/"

#Decompress
echo -en "\nCueape 0.1\n\n"
echo -en "\033[1;32mStarting conversion\n"

#Checking filetype by extension and decompressing
tmp="$(basename "$1")"
tmp="${tmp##*.}"

case "$tmp" in
[fF][lL][aA][cC]	)	
	echo -en "\033[1;32mDecompressing FLAC file\n\n"
	echo -en "\033[1;37m"
	tm="$(basename "$1")"
	tm="${tm%.[fF][lL][aA][cC]}"
	out="$(flac "-d" "$1" -o "Output/${tm}.wav" )" 
	;;
[aA][pP][eE]		)
	echo -en "\033[1;32mDecompressing APE file\n\n"
	echo -en "\033[1;37m"
	tm="$(basename "$1")"
	tm="${tm%.[aA][pP][eE]}"
	out="$(mac "$1" "Output/${tm}.wav" "-d")" 
	;;
*			)
	echo "Error: line 99"
esac

cd "Output"
echo -en "\033[1;32m\nDecompression finished\n"
echo -en "\033[1;32mStarting reencoding\n\n"
echo -en "\033[1;37m"
if [ "$3" = "-o" ] ; then 
	#Calling oggenc. Saving output for future checking
	out="$(oggenc -q 6 -o "$tm.ogg" "$tm.wav")"
	echo -en "\033[1;32m\nReencoding finished\n"
	echo -en "\033[1;32mSplitting\n\n"
	echo -en "\033[1;37m"
	out="$(mp3splt -c "$(basename "$2")" -o "@n+-+@t" "$tm.ogg")"
else
	#Calling lame. Saving output for future checking
	out="$(lame -v -h -ms "$tm.wav" "$tm.mp3")"
	echo -en "\033[1;32m\nReencoding finished\n"
	echo -en "\033[1;32mSplitting\n\n"
	echo -en "\033[1;37m"
	#Using framemode becaus this settings are for VBR
	out="$(mp3splt -f -c "$(basename "$2")" -o "@n+-+@t" "$tm.mp3")"
fi
cd "$oldir"
echo -en "\033[1;32m\nProcessing finished successfully\n"
echo -en "\033[1;37m"
exit 0
