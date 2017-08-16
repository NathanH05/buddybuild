#!/bin/bash
# IMPORTANT  DO NOT RUN THIS MANUALLY. SCRIPT IS CALLED BY INITIAL_SEARCH.sh
DISCREPANT_NODES=()
Test=()

HOSTNAME="$(hostname)"
WORKER_PROCESS="$1"
echo "${WORKER_PROCESS}"
WORKER_COUNT1="$(ps aux | grep ${WORKER_PROCESS} | wc -l)"
VIRTPROCESSORS="$(nproc --all)"
SUBTRACTOR="1"

# Subtract one for the grep process itself
WORKER_COUNT="$(expr ${WORKER_COUNT1} - ${SUBTRACTOR})"

echo "Connected to host: ${HOSTNAME}"
echo "Total running worker processes: ${WORKER_COUNT}"
echo "Total running virtual processors: ${VIRTPROCESSORS}"

if [[ "$WORKER_COUNT" -ne "$VIRTPROCESSORS" ]]; then
		echo "***DISCREPANCIES BETWEEN CORES AND WORKER PROCESSES EXIST FOR ${HOSTNAME}***"
        echo "-------------------------DISCREPANT HOSTS REPORT FOR ${HOSTNAME}-------------------------"

        DISCREPANT_NODES+=("$(hostname)")

        echo "Discrepant hosts():		# of Worker Processes 		# of Cores"
		for i in "${DISCREPANT_NODES[@]}"
		do
		    echo "${i}			${WORKER_COUNT}				${VIRTPROCESSORS}"
		done

		echo "Discrepant process running as: "
		process_user="ps aux | grep "${WORKER_PROCESS}" | sed -n '2p' | cut -d' ' -f1"
		eval $process_user

		PID=$(eval "ps aux | grep "${WORKER_PROCESS}" | sed -n '2p' | cut -d' ' -f10")
		echo "Sample discrepant process ID: "
		echo $PID
		# eval PID=$process_user
	
		CPU="ps aux | grep "${WORKER_PROCESS}" | sed -n '2p' | cut -d' ' -f12"
		echo "Sample discrepant process CPU usage: "
		eval $CPU
	
		MEM="ps aux | grep "${WORKER_PROCESS}" | sed -n '2p' | cut -d' ' -f14"
		echo "Sample discrepant process Memory usage: "
		eval $MEM

		echo "Sample discrepanct process CPUs allowed"
		CPU_ALLW="cat /proc/"${PID}"/status | grep -w Cpus_allowed: | cut -d':' -f2 | sed -n '2p'"
		eval $CPU_ALLW

		
		CPU_ALLWD="cat /proc/"${PID}"/status | grep Cpus_allowed_list: | sed -n 2p"
		eval $CPU_ALLWD
		# eval $process_user6

		echo "Sample discrepant process UID for process:"
		USERD="cat /proc/"${PID}"/status | grep Uid  | sed -n '2p'"
		eval $USERD

		echo "---------------------------END OF REPORT FOR ${HOSTNAME}---------------------------"

fi
# done
