#!/bin/bash

# SINGLE MACHINE
app="nginx"
commands="docker pull run stop rm rmi"
cnt=0

app="ubuntu"
commands="lxc launch delete"

app="nginx"
commands="rkt start stop"

# CLUSTER
BASE_DIR="test-cluster"
app="nginx"
fs=".overlay"
cluster=".swarm"
commands="docker$cluster$fs run stop rm"

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
		RES=`grep real $BASE_DIR/$prg.$cmd.$app.$i.txt|cut -f2`
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

