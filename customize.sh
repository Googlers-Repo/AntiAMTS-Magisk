if [ -a /system/etc/resolv.conf ]; then
	mkdir -p $TMPDIR/system/etc/
	printf "nameserver 157.90.236.129\nnameserver 157.90.244.22" >> $TMPDIR/system/etc/resolv.conf
	touch $TMPDIR/auto_mount
fi
