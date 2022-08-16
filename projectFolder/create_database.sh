#!/bin/bash

if [ $# -ne 1 ]; then
	echo "No parameter was provided or too many" >&2
	exit 1
elif [ -e "$1" ]; then
	echo "The database already existed" >&2
	exit 2
else
	# critical section
	while ! ln "$0" "$1-lock"  2>/dev/null; do
		sleep 1
	done
	mkdir "$1"
	echo "Everything went well"
	rm "$1-lock"
	exit 0
fi
