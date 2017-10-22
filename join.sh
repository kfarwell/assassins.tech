#!/bin/sh

cd $(dirname "$0")

for i in games/*; do
	if grep -qs "$1" "$i"; then
		echo "You cannot join a new game while you are already in one." > xmpp.krourke.org/$1/in
		exit
	fi
done

if [ ! -f games/$2.txt ]; then
	echo "Game not found. Please try another code." > xmpp.krourke.org/$1/in
	exit
fi

echo "$1" >> games/$2.txt
echo "$1 0" >> score/$2.txt
echo "Game join succeeded. Please upload a photo of your face to https://ctrlq.org/images and send the direct link as a text (this will be shared with your assassins so they can track you down). If you have played Assassins.TECH using this phone number before and already uploaded a photo, you do not need to upload one again." > xmpp.krourke.org/$1/in
