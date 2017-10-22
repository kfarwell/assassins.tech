#!/bin/sh

cd $(dirname "$0")

for i in games/*; do
        if grep -qs "$1" "$i"; then
                echo "You cannot create a new game while you are already in one." > xmpp.krourke.org/$1/in
                exit
        fi
done

code=$(shuf -i 100000-999999 -n 1)

while grep -qs $code codes.txt; do
        code=$(shuf -i 100000-999999 -n 1)
done

echo $code >> codes.txt
echo "$1" >> games/$code.txt
echo "$code" > leaders/$1.txt
echo "$1 0" >> score/$code.txt
echo "Your game code is $code. Other players can join your game by texting $code to +1 (647) 797-KILL. Text START once everyone is in the game. Please upload a photo of your face to https://ctrlq.org/images and send the direct link as a text (this will be shared with your assassins so they can track you down). If you have played Assassins.TECH using this phone number before and already uploaded a photo, you do not need to upload one again." > xmpp.krourke.org/$1/in
