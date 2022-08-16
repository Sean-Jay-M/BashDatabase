#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Error parameters problem" >&2
	exit 1
elif [ ! -d "$1" ]; then
	echo "DB does not exist" >&2
	exit 2
elif [ ! -f "$1"/"$2" ]; then
	echo "table does not exist" >&2
	exit 3
fi

IFS="," read -r -a array1 <<< "$3"
IFS="," read -r -a array2 <<< "$(head -n 1 "$1"/"$2")"

if [ ${#array1[@]} != ${#array2[@]} ]; then
	echo "Wrong tuple length" >&2
	exit 4
else
	while ! ln "$0" "$1-lock" 2>/dev/null; do
		sleep 1
	done
	echo "$3" >> "$1"/"$2"
	echo "Tuple inserted"
	rm "$1-lock"
	exit 0
fi
