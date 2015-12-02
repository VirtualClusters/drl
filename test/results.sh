#!/bin/bash

app="nginx"
commands="docker pull run stop rm rmi"
cnt=0

for cmd in $commands
do
	if [ $cnt -eq 0 ]
	then
		prg=$cmd
		cnt=1
		continue
	fi
	for i in `seq 1 1024`
	do
		#echo grep real $prg.$cmd.$app.$i.txt
		RES=`grep real $prg.$cmd.$app.$i.txt|cut -f2`
		if [ "$RES" == "" ]
		then
			echo ===============================
			echo Stopped at $i
			echo ===============================
			break
		else
			min=`echo $RES|cut -d"m" -f1`
			sec=`echo $RES|cut -d"m" -f2|cut -d"s" -f1`
			bc=`echo $min + $sec|bc`
			tmp=`echo -n "$bc,"`
			data=$data$tmp
		fi
	done
	echo $data > $prg.$cmd.$app.csv
	data=""
done

