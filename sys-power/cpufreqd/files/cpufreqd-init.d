#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/files/cpufreqd-init.d,v 1.1 2007/05/17 08:51:45 phreak Exp $

CONFIGFILE=/etc/cpufreqd.conf

depend() {
	need localmount
	use logger lm_sensors
}

checkconfig() {
	if [[ ! -f ${CONFIGFILE} ]]; then
		eerror "Configuration file ${CONFIGFILE} not found"
		return 1
	fi

	if [[ ! -e /proc/cpufreq ]] ; then
		for cpu in /sys/devices/system/cpu/cpu[0-9]* ; do
                        # We need just one cpu supporting freq scaling.
                        [[ -e ${cpu}/cpufreq ]] && return 0
		done
		eerror "cpufreqd requires the kernel to be configured with CONFIG_CPU_FREQ"
		eerror "Make sure that the appropiate drivers for your CPU are available."
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting CPU Frequency Daemon"
	start-stop-daemon --start --exec /usr/sbin/cpufreqd -- \
		-f ${CONFIGFILE}
	eend ${?}
}

stop() {
	ebegin "Stopping CPU Frequency Daemon"
	start-stop-daemon --stop --exec /usr/sbin/cpufreqd
	eend ${?}
}
