#/bin/bash
echo $1
cat $1
eval `cat $1`
systemctl stop $SERV
rkt rm $UUID

