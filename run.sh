#!/bin/sh

cd $(dirname "$0")

killall switch.sh
./switch.sh >/dev/null 2>/dev/null &
