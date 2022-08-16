#!/bin/bash

mkfifo server.pipe

while true; do

read -r -a array0 < server.pipe

id=("${array0[0]}")
array1=("${array0[@]:1}")

case "${array1[0]}" in
	create_database)
		./create_database.sh "${array1[1]}" &> "$id".upipe
		;;
	create_table)
		./create_table.sh "${array1[1]}" "${array1[2]}" "${array1[3]}" &> "$id".upipe
		;;
	insert)
		./insert.sh "${array1[1]}" "${array1[2]}" "${array1[3]}" &> "$id".upipe
		;;
	select)
		./select.sh "${array1[1]}" "${array1[2]}" "${array1[3]}" &> "$id".upipe
		;;
	select_where)
		./select_where.sh "${array1[1]}" "${array1[2]}" "${array1[3]}" "${array1[4]}" &> "$id".upipe
		;;
	shutdown)
		echo "the server is shutting down"
		rm server.pipe
		exit 0
	;;
	*)
		echo "Error: bad request" >&2
		exit 1
	esac
done
