#!/bin/sh

cd $(dirname "$0")

if [ ! -f leaders/$1.txt ]; then
	echo "Only the game leader can start the game." > xmpp.krourke.org/$1/in
	exit
fi
gid=$(cat leaders/$1.txt)

if [ $(wc -l games/$gid.txt | cut -d " " -f 1) = "1" ]; then
	echo "You need at least two players to start the game." > xmpp.krourke.org/$1/in
	exit
fi


if grep -q "true" leaders/$1.txt; then
	echo "Game already started." > xmpp.krourke.org/$1/in
	exit
fi

missing=false
while read line; do
	if ! grep -q "$line" pictures.txt; then
		echo "Please upload a selfie or picture of your face to https://ctrlq.org/images and send the direct link as a text. Your game is waiting on you to start." > xmpp.krourke.org/$line/in
                missing=true
        fi
done < games/$gid.txt

if [ "$missing" = true ]; then
        echo "You cannot start your game. There is still a user who has not submitted a photo. They have been notified." > xmpp.krourke.org/$1/in
        exit
fi

echo "true" >> leaders/$1.txt
shuf games/$gid.txt > tmp
mv tmp games/$gid.txt

while read line; do
	code=$(shuf -i 10000000-99999999 -n 1)
	while grep -qs $code codes.tmp; do
		code=$(shuf -i 10000000-99999999 -n 1)
	done
	echo $code >> codes.tmp
	echo "$line $code" >> $gid.tmp
done < games/$gid.txt

mv $gid.tmp games/$gid.txt

for line in $(seq $(wc -l games/$gid.txt | cut -d " " -f 1)); do
	num=$(sed -n $line'p' games/$gid.txt | cut -d " " -f 1)
	code=$(sed -n $line'p' games/$gid.txt | cut -d " " -f 2)

	if [ "$line" = $(wc -l games/$gid.txt | cut -d " " -f 1) ]; then
		line=0
	fi
	num2=$(sed -n $(($line + 1))'p' games/$gid.txt | cut -d " " -f 1)

	for imageline in $(seq $(wc -l pictures.txt | cut -d " " -f 1)); do
		num3=$(sed -n $imageline'p' pictures.txt | cut -d " " -f 1)
		if [ "$num2" = "$num3" ]; then
			picture=$(sed -n $imageline'p' pictures.txt | cut -d " " -f 2)
		fi
	done

	echo "Your code is $code. Write this on a piece of paper and secure it to your hat. Here is your target's picture: $picture. Find them and text me the code attached to their hat to earn a point." > xmpp.krourke.org/$num/in
done
