#!/bin/sh

cd $(dirname "$0")

if [ ! -f leaders/$1.txt ]; then
	echo "Only the game leader can stop the game early." > xmpp.krourke.org/$1/in
	exit
fi

gid=$(head -n 1 leaders/$1.txt)
./end.sh $gid
