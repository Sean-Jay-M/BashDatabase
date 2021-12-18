#!/bin/bash
if [ $# -ne 3 ]; then
        echo "Too few or many parameters" >&2
        exit 1
elif [ ! -d "$1" ]; then
        echo "The database does not exist" >&2
        exit 2
elif [ -f "$1"/"$2" ]; then
	echo "The table already exists" >&2
	exit 3
else
	# critical section
	while ! ln "$0" "$1-lock" 2>/dev/null; do
		sleep 1
	done
	touch "$1"/"$2"
	echo "$3" > "$1"/"$2"
	echo "Everything went well"
	rm "$1-lock"
	exit 0
fi
