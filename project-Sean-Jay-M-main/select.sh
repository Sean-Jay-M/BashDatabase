#!/bin/bash

if [ $# -ne 3 ]; then
        echo "Error: parameters problem" >&2
        exit 1
elif [ ! -d "$1" ]; then
        echo "Error: DB does not exist" >&2
        exit 2
elif [ ! -f "$1"/"$2" ]; then
        echo "Error: Table does not exist" >&2
        exit 3
fi

IFS="," read -r -a array0 <<< "$3"
IFS="," read -r -a array2 <<< "$(head -n 1 "$1"/"$2")"

arrayhold=()
num=1

for i in "${array0[@]}"
do
	arrayhold+="$(($i-$num)),"
done

IFS="," read -r -a array1 <<< "${arrayhold[@]}"

num2=-1

for i in "${array1[@]}"
do
	if [ "$i" == "$num2" ]; then
		echo "Error: Column does not exist" >&2
		exit 4
	elif [ $i -lt ${#array2[@]} ]; then
		continue
	else
		echo "Error: Column does not exist" >&2
		exit 4
	fi
done
while ! ln "$0" "$1-lock" 2>/dev/null;do
	sleep 1
done
cat "$1"/"$2" | while read line
do
	declare -a variable_array
	IFS="," read -r -a array3 <<< "$line"
	for i in "${array1[@]}"
	do
		variable_array+=(${array3["$i"]})
	done
	echo "${variable_array[*]}"
	variable_array=()
done
rm "$1-lock"
exit 0
