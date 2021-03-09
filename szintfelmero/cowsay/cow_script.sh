#! /bin/bash

count=0
timeout=100

# Variables
WAITFILE_SENTENCE="I don't know what to say..."
BAILOUT_SENTENCE="Too late. See you next time!"
FNAME="/root/sentences.log"
# Wait a bit
SLEEP="6"
# Docker shared volume
NGINX_FILE="/root/shared/index.html"

function leave_some_space {
	echo
	echo
	echo
}

# Wait for the file to be copied in the right location

while [[ ! -f $FNAME && "$count" -lt "$timeout" ]];
do
	cowsay $WAITFILE_SENTENCE > $DEST
	sleep $SLEEP
	count=$((count+$SLEEP))
done

# If the file is not there after timeout, bail out
if [ "$count" -eq "$timeout" ];
then
	leave_some_space
	cowsay $BAILOUT_SENTENCE
	exit 0
fi

# If i have the file, read it line by line and cowsay
while read -r line
do
	leave_some_space
	cowsay $line > $NGINX_FILE
	sleep $SLEEP
done < $FNAME