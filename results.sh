#!/bin/bash

num=`seq 1 1024`

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

#LXC
app="trusty"
commands="lxc launch stop delete"
nodes=`seq 159 167`
num=`seq 1 100`

#rkt fleet
app="nginx"
cluster=".fleet"
commands="rkt$cluster start stop destroy"
num="a b c d"
nodes="a b c d e f g h i j k l m n o p q r s t u v w x y z"

for cmd in $commands
do
	if [ $cnt -eq 0 ]
	then
		prg=$cmd
		cnt=1
		continue
	fi
	for i in $num
	do
	
		ii=$i
		for j in $nodes
		do
		for k in `seq 1 10`
		do
		i="$ii$j$k"
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
			bc=`echo "$min * 60 + $sec"|bc`
			tmp=`echo -n "$bc,"`
			data=$data$tmp
		fi
		done
		done
	done
	echo $data > $prg.$cmd.$app.csv
	data=""
done

