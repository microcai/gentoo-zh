ifeq (${SRCDIR},)
	SRCDIR=$(shell pwd)
endif
DATA:=${SRCDIR}/data

all:
	@echo "build rime im data resource"
	@mkdir -p ${DATA}
	@cp default.yaml ${DATA}
	@cp essay.kct  ${DATA}
	@cp supplement/*.yaml  ${DATA}
	@cp preset/*.yaml  ${DATA}
	rime_deployer --build  ${DATA}
	@rm ${DATA}/rime.log

install:
	@echo "install rime IM data resource"
	@install -d ${DESTDIR}/usr/share/rime/data
	@install ${DATA}/* ${DESTDIR}/usr/share/rime/data
