#!/bin/bash

trap ctrl_c INT

function ctrl_c(){
	rm "$identification".upipe
	echo " Logging off"
	exit 0
}
if [ $# -ne 1 ]; then
	echo "The number of parameters is wrong" >&2
	exit 1
else
	identification="$1"
	echo "Welcome $identification"
	mkfifo "$identification".upipe
	while true; do
		read -r -a inputs
		echo "$identification" "${inputs[@]}" > server.pipe
		while read -r serverresults < "$identification".upipe
		do
			echo "$serverresults"
		done
	done
fi



