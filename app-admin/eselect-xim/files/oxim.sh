#!/bin/sh
#
# Open X Input Method startup script.
#
# By Firefly.
#

OXIM_IM_MODULE_DIR="/usr/lib/oxim/immodules"
XIM=oxim
XMODIFIERS="@im=${XIM}"
XIM_PROGRAM=oxim
XIM_ARGS="-x oxim"

USR_DIR="$HOME/.oxim"
GTK_IM_MODULE_FILE="${USR_DIR}/gtk.immodules"

# 找出 gtk-query-immodules 指令的完整路徑與真正名稱
for cmd in gtk-query-immodules-2.0-64 \
	   gtk-query-immodules-2.0-32 \
	   gtk-query-immodules-2.0    \
	   gtk-query-immodules
do
    TEST_CMD=`which ${cmd} 2>/dev/null`
    if [ ! -z ${TEST_CMD} ]
    then
	GTK_QRY_CMD=${TEST_CMD}
	break
    fi
done

# 檢查 OXIM 的 GTK2 輸入模組是否安裝
if [ -f ${OXIM_IM_MODULE_DIR}/gtk-im-oxim.so ] ; then
    # 檢查使用者家目錄之下是否有下列目錄
    if [ ! -d ${USR_DIR} ] ; then
	mkdir -p ${USR_DIR}
    fi

    # 建一個 gtk im modules 的紀錄檔
    if [ ! -z ${GTK_QRY_CMD} ] ; then
	${GTK_QRY_CMD} > ${GTK_IM_MODULE_FILE}
    else
	# 否則只建立自己的 immodule 紀錄
	echo "\"${OXIM_IM_MODULE_DIR}/gtk-im-oxim.so\"" > ${GTK_IM_MODULE_FILE}
	echo "\"oxim\" \"Open X Input Method\" \"gtk20\" \"/usr/share/locale\" \"*\"" >> ${GTK_IM_MODULE_FILE}
    fi
    GTK_IM_MODULE=oxim
    export GTK_IM_MODULE_FILE
else
    GTK_IM_MODULE=xim
fi


# 檢查 OXIM 的 QT 輸入模組是否安裝
if [ -f ${OXIM_IM_MODULE_DIR}/qt-im-oxim.so ] ; then
    export QT_IM_MODULE=oxim
fi
