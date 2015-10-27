#!/bin/bash

SERVICE=`systemd-run rkt run nginx --mds-register=false --volume volume-var-cache-nginx,kind=host,source=/var/nginx 2>&1`
SERVICE=`echo $SERVICE|awk ' { print $4 }'`
SERV=${SERVICE::-1}
UUID=`systemctl status $SERV |awk '/uuid/ { print $8 } '|awk -F"=" ' { print $2 }'`
while [ "$UUID" == "" ]
do
	sleep .1
	echo -n "."
	UUID=`systemctl status $SERV |awk '/uuid/ { print $8 } '|awk -F"=" ' { print $2 }'`
done

UUID=`echo $UUID|awk ' { print $1 } '`

cat <<EOF > .$1.info
UUID=$UUID
SERV=$SERV
EOF
