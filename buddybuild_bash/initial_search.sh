#!/bin/bash

# IMPORTANT: USING THIS SCRIPT PLEASE PASS WORKER NAME, TEXT FILE PATH OF HOSTS AND SSH USER
# IMPORTANT: THIS SCRIPT ASSUMES THE USER HAS RQ'D SSH ACCESS
# IMPORTANT: Example use of script 'sh initial_search.sh kworker hosts.txt nhampshire'

HOSTCOUNT="$(cat $2 | wc -l)"
HOSTCOUNT_ARRAY=()
HOSTCOUNT_FILE="$(cat $2)"
USR="${3}" 
# echo $STRINGTEST
j=0
HOSTARRAY=(${HOSTCOUNT_FILE[@]})

for i in "${HOSTARRAY[@]}" 
do
	
	WORKER_PROCESS="$1"

	echo "Total host count: ${HOSTCOUNT}"
	echo "Copying shell script to host"
	copy="scp host_connector.sh ${USR}@${HOSTARRAY[j]}:~"
	eval $copy	
	
	echo "Connecting to ${HOSTCOUNT} hosts...."
	str1="ssh ${USR}@${HOSTARRAY[j]} 'bash host_connector.sh '"${WORKER_PROCESS}"' '"$2"''"
	eval $str1
	j+=1


done
