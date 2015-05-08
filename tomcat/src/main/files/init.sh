#!/bin/bash

echo "Docker container started!"
echo ""

# Directory containing all init scripts. Those scripts need to be in a lexicographical order!
if [ -z "${INIT_DIR}"]
then
	echo "INIT_DIR not set! Trying to use ${PWD}/init as INIT_DIR"
	export INIT_DIR="${PWD}/init"
fi
# Check if INIT_DIR exists or is empty. If yes return error code 1.
if [ ! `ls -A ${INIT_DIR}` ]
then
	echo "${INIT_DIR} is empty or does not exist! Exiting!!!"
	return 1
fi

# Make every *.sh script executable. Doing this here prevents us of doing it in every Dockerfile based on this base image!
chmod +x ${INIT_DIR}/*.sh 

# Execute every executable file in INIT_DIR.
for SCRIPT in ${INIT_DIR}/*
do
	if [ -f ${SCRIPT} -a -x ${SCRIPT} ]
	then
		${SCRIPT}
	fi
done

# Return exit code 2 because we don't want our container to reach this line or it will stop!
echo "Docker container finished processing scripts. Please contact maintainer as this container shouldn't finish!!! Exiting!!!"
return 2
