#!/bin/bash

#set -e

WEBSERVER="$2"
SOCQUETTE="socat unix-connect:/var/run/haproxy.stat stdio"
SERVERS="grep web /etc/hosts | awk '{print $3}' ORS=' '; echo"
BACKEND="www.famihero.com"
VERT="\\033[1;32m"
ROUGE="\\033[1;31m"
NORMAL="\\033[0;39m"

print_help() {
cat << EOF

Script to manage servers in HaProxy - Read README.TXT
Copyright (c) Cyril Beaufrere <cyril.beaufrere@gmail.com>
Version: 1.1
Last Modified: 10 Janvier 2013
License : This software can be used for free unless I meet you, then you owe me lunch.

Usage: wwwcluster.sh -d| -e| -a| -h| -m| -s [webserver]

Options:

-d [webserver]: To disable server
-e [webserver]: To enable server
-a: Enable all servers
-h: This stupid help
-m: Disable all servers (maintenance mode)
-s: Show status of all web servers

EOF
        }


disable_server () {
echo -e "$ROUGE""---------------------------------- " "$NORMAL"
echo "Do you want to disable $WEBSERVER? (y/n)"
echo -e "$ROUGE""---------------------------------- " "$NORMAL"
read reponse
	if [[ $reponse == "y" ]]
	then echo disable server $BACKEND/$WEBSERVER | $SOCQUETTE
	sleep 2
	echo show stat | $SOCQUETTE  | grep $WEBSERVER | grep -v check | awk -F'[,|]' '{print $2 " ===> "$18}' OFS=","
fi
	if [[ $reponse == "n" ]]
	then echo "###Leaving###"
fi
}


enable_server () {
echo -e "$VERT""---------------------------------- " "$NORMAL"
echo "Do you want to enable $WEBSERVER? (y/n)"
echo -e "$VERT""---------------------------------- " "$NORMAL"
read reponse
	if [[ $reponse == "y" ]]
	then echo enable server $BACKEND/$WEBSERVER | $SOCQUETTE
	sleep 2
	echo -e show stat | $SOCQUETTE | grep $WEBSERVER | grep -v check | awk -F'[,|]' '{print $2 " ===> "$18}' OFS=","
fi
	if [[ $reponse == "n" ]]
	then echo "###Leaving###"
fi
}


maintenance () {
echo -e "$ROUGE""---------------------------------------- " "$NORMAL"
echo "Do you want to enable maintenance? (y/n)"
echo -e "$ROUGE""---------------------------------------- " "$NORMAL"
read reponse
	if [[ $reponse == "y" ]]
	then
	for i in $SERVERS
	do
	echo disable server $BACKEND/$i | $SOCQUETTE
	sleep 2
	done
check_status
fi
     if [[ $reponse == "n" ]]
     then echo "###Leaving###"
fi 
}

enable_all () {
echo "Do you want to enable all servers? (y/n)"
read reponse
        if [[ $reponse == "y" ]]
        then
        for i in $SERVERS
        do
        echo enable server $BACKEND/$i | $SOCQUETTE
        sleep 2
        done
check_status
fi
     if [[ $reponse == "n" ]]
     then echo "###Leaving###"
fi
}


check_status () {
for i in $SERVERS
do
echo show stat | $SOCQUETTE | grep $i | grep -v check | awk -F'[,|]' '{print $2 "===>"$18}' OFS="," 
        done
}

if (($# == 0)); then
print_help
fi

while getopts smdeha pouet
do	case "$pouet" in
	d)	disable_server;;
	e)	enable_server;;
	[?])	print_help;;
	'#$') print_help;;
	a)	enable_all;;
	s)	check_status;;
	m)	maintenance;;
	h)	print_help;;

	esac
done

