#!/bin/bash

gid=""

for i in games/*.txt; do
	if grep -qs "$1" $i; then
		gid=$(echo $i | sed 's,games/\([0-9]*\).txt,\1,')
	fi
done

for line in $(seq $(wc -l games/$gid.txt | cut -d " " -f 1)); do
	num=$(sed -n $line'p' games/$gid.txt | cut -d " " -f 1)

	if [ "$num" = "$1" ]; then
		if [ "$line" = $(wc -l games/$gid.txt | cut -d " " -f 1) ]; then
			line=0;
		fi

		code=$(sed -n $(($line + 1))'p' games/$gid.txt | cut -d " " -f 2)
		if [ "$code" = "$2" ]; then
			./score.sh $1 $gid

			num2=$(sed -n $(($line + 1))'p' games/$gid.txt | cut -d " " -f 1)

			echo "Ha ha, U R DED. Better luck next time scrub. Get good." > xmpp.krourke.org/$num2/in

			sed -i $(($line + 1))'d' games/$gid.txt

			if [ $(wc -l games/$gid.txt | cut -d " " -f 1) = 1 ]; then
				echo "Congratulations, you're the last player standing!" > xmpp.krourke.org/$num/in
				./end.sh $gid
				exit
			fi

			if [ "$line" = $(wc -l games/$gid.txt | cut -d " " -f 1) ]; then
				line=0
			fi
			num2=$(sed -n $(($line + 1))'p' games/$gid.txt | cut -d " " -f 1)

			picture=""
			for imageline in $(seq $(wc -l pictures.txt | cut -d " " -f 1)); do
				num3=$(sed -n $imageline'p' pictures.txt | cut -d " " -f 1)
				if [ "$num2" = "$num3" ]; then
					picture=$(sed -n $imageline'p' pictures.txt | cut -d " " -f 2)
				fi
			done
			echo "Your new target's picture is $picture. Good luck!" > xmpp.krourke.org/$num/in
		else
			echo "Incorrect target. Please try again." > xmpp.krourke.org/$num2/in
		fi
		exit
	fi
done
