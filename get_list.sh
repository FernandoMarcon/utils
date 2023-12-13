#!/bin/bash

FILE=$1
echo $FILE
while IFS= read -r line

do
	echo "$line"
	youtube-dl -f 'best' --id $line

	sleep 5
done < "$FILE"
