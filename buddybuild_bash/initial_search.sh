#!/bin/bash

# IMPORTANT: USING THIS SCRIPT PLEASE PASS WORKER NAME, TEXT FILE PATH OF HOSTS AND SSH USER
# IMPORTANT: THIS SCRIPT ASSUMES THE USER HAS RQ'D SSH ACCESS

HOSTCOUNT="$(cat $2 | wc -l)"
HOSTCOUNT_ARRAY=()
HOSTCOUNT_FILE="$(cat $2)" 
# echo $STRINGTEST
j=0
HOSTARRAY=(${HOSTCOUNT_FILE[@]})

for i in "${HOSTARRAY[@]}" 
do
	
	WORKER_PROCESS="$1"

	echo "Total host count: ${HOSTCOUNT}"
	echo "Connecting to ${HOSTCOUNT} hosts...."
	
	str1="ssh nhampshire@${HOSTARRAY[j]} 'bash host_connector.sh '"${WORKER_PROCESS}"' '"$2"''"
	eval $str1
	j+=1


done
