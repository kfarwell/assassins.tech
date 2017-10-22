#!/bin/sh

cd $(dirname "$0")

num=$1
group=$2

old=$(grep "^$num" score/$group.txt | sed 's/.* //')
new=$(echo $old | awk 'echo $num++')
sed -i 's/'"$num $old"'/'"$num $new"'/' score/$group.txt
