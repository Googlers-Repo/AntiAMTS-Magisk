#!/system/bin/sh
MODDIR=${0%/*}

iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 157.90.236.129:53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 157.90.244.22:53
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 157.90.236.129:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 157.90.244.22:53
