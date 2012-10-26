#!/usr/bin/make -f
# -*- mode: makefile; indent-tabs-mode: t -*- vim:noet:ts=4
# Sample Makefile for lexicon generation and installation.
# Copied and modified doc/SLM-inst.mk from sunpinyin project.

# The variable ${ENDIANNESS} needs to be set to either `le' or `le'.
# Little endian arch's: alpha amd64 amd64-fbsd arm hurd-i386 ia64 sh x86 x86-fbsd
# Big endian arch's: hppa m68k mips powerpc ppc64 s390 sparc sparc-fbsd
# Here we do not give a default choice.

DICT_FILE = dict.utf8

SLM_TARGET = lm_sc
TSLM3_TEXT_FILE = ${SLM_TARGET}.t3g.arpa
TSLM3_ORIG_FILE = ${SLM_TARGET}.t3g.orig
TSLM3_DIST_FILE = ${SLM_TARGET}.t3g

PYTRIE_FILE = pydict_sc.bin
PYTRIE_LOG_FILE = pydict_sc.log

SYSTEM_DATA_DIR = ${DESTDIR}/usr/share/sunpinyin

all: slm3_dist
install: slm3_install

tslm3_orig: ${TSLM3_ORIG_FILE}
${TSLM3_ORIG_FILE}: ${DICT_FILE} ${TSLM3_TEXT_FILE}
	tslmpack ${TSLM3_TEXT_FILE} ${DICT_FILE} $@

tslm3_dist: ${TSLM3_DIST_FILE}
${TSLM3_DIST_FILE}: ${TSLM3_ORIG_FILE}
	tslmendian -e ${ENDIANNESS} -i $^ -o $@

lexicon3: ${DICT_FILE} ${TSLM3_ORIG_FILE}
	genpyt -e ${ENDIANNESS} -i ${DICT_FILE} -s ${TSLM3_ORIG_FILE} \
		-l ${PYTRIE_LOG_FILE} -o ${PYTRIE_FILE}

slm3_dist: ${TSLM3_DIST_FILE} lexicon3
slm3_install: ${TSLM3_DIST_FILE} ${PYTRIE_FILE}
	install -d ${SYSTEM_DATA_DIR}
	install -Dm644 $^ ${SYSTEM_DATA_DIR}

