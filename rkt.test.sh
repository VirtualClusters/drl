#!/bin/bash

for i in `seq 1 253`
do
	if [ "$1" == "start" ]
	then 
		{ time bash rkt.nginx.start.sh $i ; } 2> test/rkt.nginx.start.$i.txt
	fi
	echo $i

	if [ "$1" == "stop" ]
	then
		{ time bash rkt.stop.sh ".$i.info" ; } 2> test/rkt.nginx.stop.$i.txt
		
	fi

	#machinectl poweroff rkt-$UUID
done
