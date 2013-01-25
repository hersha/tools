#!/bin/bash

if [ -n "$1" ] 
then
	FOLDER=$1
else
	echo "Error: Must include folder name for new Mongodb binaries."
	exit 1
fi
if [ -d "/usr/local/mongodb/$1" ]; then
	LINK=$(readlink /usr/local/bin/mongo)
	if [[ $LINK =~ (/usr/local/mongodb/)(.*?)(/bin/mongo) ]]; then
		echo "Updating MongoDB from ${BASH_REMATCH[2]} to $1"
	fi
	FILES=(`ls /usr/local/mongodb/$1/bin`)
	echo ${FILES[@]}
	for file in "${FILES[@]}"
	do
		ln -sf /usr/local/mongodb/$1/bin/${file} /usr/local/bin/${file}
	done
else
	echo "Error: Folder specified does not exist in /usr/local/mongodb/"
	exit 1
fi
service mongod stop
service mongod start