#!/sbin/runscript

description="Phddns daemon"
depend() {
	need dbus
}

start() {
        phddns -d
}

stop() {
        killall phddns
}
