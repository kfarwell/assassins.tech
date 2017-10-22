#!/bin/bash

cd $(dirname "$0")

while true; do
	for i in xmpp.krourke.org/*\@cheogram.com/out; do
		user=$(basename $(dirname "$i"))
		msg=$(tail -n 1 "$i" | sed 's/.*> //')
		msgcaps=$(echo "$msg" | tr 'a-z' 'A-Z')
		rm -f "$i"
	
		[[ "$msgcaps" == HELP ]] && echo "Enter NEW to start a new game. Enter START to begin a game once all players have joined. Enter a 6-digit game code to join a game. Enter an 8-digit player code when you have found a target. Enter STOP to end your game early. For more information, see: http://Assassins.TECH." > xmpp.krourke.org/$user/in && break
		[[ "$msgcaps" == NEW ]] && ./onboard.sh "$user" && break
		[[ "$msg" =~ ^[0-9]{6}$ ]] && ./join.sh "$user" "$msg" && break
		[[ "$msg" =~ ^https://i.imgur.com/[a-zA-Z0-9]{7}.jpg$ ]] && ./image.sh "$user" "$msg" && break
		[[ "$msgcaps" == START ]] && ./start.sh "$user" && break
		[[ "$msg" =~ ^[0-9]{8}$ ]] && ./kill.sh "$user" "$msg" && break
		[[ "$msgcaps" == STOP ]] && ./stop.sh "$user" && break
		echo "I didn't understand your command. Enter HELP for help." > xmpp.krourke.org/$user/in
	done
done
