#!/bin/bash

cd $(dirname "$0")

sed '/$1/d' pictures.txt

echo "$1 $2" >> pictures.txt
