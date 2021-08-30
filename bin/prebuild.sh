#!/bin/bash

# create .env
input="assets/.env.example"
echo -n "" > assets/.env
while IFS= read -r line
do
	if [ "$line" != "" ]; then
		key="$(echo $line | cut -d "=" -f 1)";
		value="$(echo $line | cut -d "=" -f 2)";
		newValue="$(env | grep $key=)";
		if [ "$newValue" != "" ]; then
			value="$(echo $newValue | cut -d "=" -f 2)";
		fi
		echo "$key=$value" >> assets/.env;
	fi
done < "$input"

# print enviroment variables
cat assets/.env
export