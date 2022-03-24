#!/system/bin/sh

if [ -n "$MMM_EXT_SUPPORT" ]; then
  ui_print "#!useExt"
  mmm_exec() {
    ui_print "$(echo "#!$@")"
  }
else
  mmm_exec() { true; }
  abort "! This module need to be executed in Fox's Magisk Module Manager"
  exit 1
fi

if [ -a /system/etc/resolv.conf ]; then
	mkdir -p $TMPDIR/system/etc/
	printf "nameserver 157.90.236.129\nnameserver 157.90.244.22" >> $TMPDIR/system/etc/resolv.conf
	touch $TMPDIR/auto_mount
fi
