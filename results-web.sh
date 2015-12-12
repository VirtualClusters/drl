
tool='docker rkt lxc'
app='nginx'

for k in $tool
do
	TMP2=""
	for j in `echo 1 10 100 1000`
	do
		TMP=""
		for i in `seq 1000 1000 10000`
		do
			#echo $k.$app.$i.$j.txt
			RES=`grep 'Time per request' test-nginx/$k.$app.$i.$j.txt |grep 'across'|cut -d":" -f2|awk ' { print $1 } '`
			TMP=$TMP`echo -n "$RES,"`
		done
		TMP2=$TMP2`echo "[$TMP],"`
	done
 	echo "[$TMP2]" > $k.$app.web.csv
done
