#!/system/bin/sh
MODDIR=${0%/*}

setprop net.eth0.dns1 157.90.236.129
setprop net.eth0.dns2 157.90.244.22

setprop net.dns1 157.90.236.129
setprop net.dns2 157.90.244.22

setprop net.ppp0.dns1 157.90.236.129
setprop net.ppp0.dns2 157.90.244.22

setprop net.rmnet0.dns1 157.90.236.129
setprop net.rmnet0.dns2 157.90.244.22

setprop net.rmnet1.dns1 157.90.236.129
setprop net.rmnet1.dns2 157.90.244.22

setprop net.pdpbr1.dns1 157.90.236.129
setprop net.pdpbr1.dns2 157.90.244.22

setprop 2606:4700:4700::15790236129
setprop 2606:4700:4700::1579024422



# Edit the resolv conf file if it exist

if [ -a /system/etc/resolv.conf ]; then
	mkdir -p $MODDIR/system/etc/
	printf "nameserver 157.90.236.129\nnameserver 157.90.244.22" >> $MODDIR/system/etc/resolv.conf
	chmod 644 $MODDIR/system/etc/resolv.conf
fi
