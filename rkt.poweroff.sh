for i in `machinectl list|awk ' { print $1 }'|cut -c 5-`
do
	echo $i
	{ time machinectl poweroff rkt-$i; rkt rm $i ; } 2> test.rkt.nginx.stop.$i.txt
done
