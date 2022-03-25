#!/system/bin/sh
MODDIR=${0%/*}

iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 157.90.236.129:53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 157.90.244.22:53
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 157.90.236.129:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 157.90.244.22:53

iptables -A PREROUTING -t nat -p tcp --dport 1260 -j REDIRECT --to-port 1260
iptables -A OUTPUT -t nat -p tcp --dport 1260 -j REDIRECT --to-port 1260

# Wait for boot to finish completely
dbg "Sleeping until boot completes."
while [[ `getprop sys.boot_completed` -ne 1 ]]
do
  sleep 1
done

# Sleep an additional 20s to ensure init is finished
sleep 20

# Start the server
amts-server 1260 /data/local/amts-server &

isActive=`curl -s 'https://cdn.dergoogler.com/others/amts-magisk/notification.json' | grep -Po '(?<="active":")(.*?)(?=",)'`;
getCurrentNewsTitle=`curl -s 'https://cdn.dergoogler.com/others/amts-magisk/notification.json' | grep -Po '(?<="title":")(.*?)(?=",)'`;
getCurrentNewsMessage=`curl -s 'https://cdn.dergoogler.com/others/amts-magisk/notification.json' | grep -Po '(?<="message":")(.*?)(?=",)'`;

if [ isActive = true ]; then
  while true; do
    exec su -lp 2000 -c "cmd notification post -S bigtext -t '$getCurrentNewsTitle' 'Tag' '$getCurrentNewsMessage'"
    # sleep 24 hours
    sleep $((24 * 60 * 60))
  done
fi