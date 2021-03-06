# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn/files/rc-addon-0.0.9.sh,v 1.2 2007/04/17 12:40:40 zzam Exp $
#
# rc-addon-script for plugin burn
#

: ${BURN_DVDWRITER:=/dev/dvd}
: ${BURN_DATADIR:=/var/vdr/video}
: ${BURN_ISODIR:=/var/vdr/video/dvd-images}

plugin_pre_vdr_start() {

add_plugin_param "-d ${BURN_DATADIR}"

if [ ! -f /usr/bin/burnmark.sh ] ; then

  # works on burn-0.0.5
  if [ "${BURN_CREATEONLY_ISO:=no}" = "yes" ] ; then
    add_plugin_param "-i ${BURN_ISODIR}"
  else
    add_plugin_param "-D ${BURN_DVDWRITER}"
  fi
  
else

  # works on >=burn-0.0.9
  add_plugin_param "-i ${BURN_ISODIR}"
  add_plugin_param "-D ${BURN_DVDWRITER}"

fi

}
 		 
