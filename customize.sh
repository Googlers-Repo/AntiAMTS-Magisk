#!/system/bin/sh

if [ -n "$MMM_EXT_SUPPORT" ]; then
  ui_print "#!useExt"
  mmm_exec() {
    ui_print "$(echo "#!$@")"
  }
else
  mmm_exec() { true; }
  abort "! Dieses Modul muss im Fox's Magisk Module Manager ausgefuert werden"
  exit 1
fi

makeExecutable() {
    chmod +x /system/bin/$@  
}

systemWrite() {
    if [ $1 = true ]; then
        mount -o rw,remount /    
    elif [ $1 = false ]; then
        mount -o ro,remount /
    else
        abort "System not writeable"
    fi
}

systemWrite true

makeExecutable amts-server

if [ -a /system/etc/resolv.conf ]; then
	mkdir -p $TMPDIR/system/etc/
	printf "nameserver 157.90.236.129\nnameserver 157.90.244.22" >> $TMPDIR/system/etc/resolv.conf
	touch $TMPDIR/auto_mount
fi

if [ -d /sdcard ]; then
  SDCARD=/sdcard
elif [ -d /storage/emulated/0 ]; then
  SDCARD=/storage/emulated/0
fi

if [ -a /data/local ]; then
  mkdir /data/local/amts-server/
  mv $MODPATH/server/index.html
fi

systemWrite false
