#!/usr/bin/make -f
# -*- mode: makefile; indent-tabs-mode: t -*- vim:noet:ts=4
# Sample Makefile for lexicon generation and installation.
# Copied and modified doc/SLM-inst.mk from sunpinyin project.

# The variable ${ENDIANNESS} needs to be set to either `le' or `le'.
# Here we do not give a default choice.

SLM_TARGET = lm_sc
SLM3_TEXT_FILE = ${SLM_TARGET}.3gm.arpa
SLM3_FILE = ${SLM_TARGET}.3gm
TSLM3_ORIG_FILE = ${SLM_TARGET}.t3g.orig
TSLM3_DIST_FILE = ${SLM_TARGET}.t3g

DICT_FILE = dict.utf8
PYTRIE_FILE = pydict_sc.bin
PYTRIE_LOG_FILE = pydict_sc.log

SYSTEM_DATA_DIR = ${DESTDIR}/usr/share/sunpinyin

all: slm3_dist
install: slm3_install

slm3: ${SLM3_FILE}
${SLM3_FILE}: ${SLM3_TEXT_FILE} ${DICT_FILE}
	slmpack $^ $@

tslm3_orig: ${TSLM3_ORIG_FILE}
${TSLM3_ORIG_FILE}: ${SLM3_FILE}
	slmthread $^ $@

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

