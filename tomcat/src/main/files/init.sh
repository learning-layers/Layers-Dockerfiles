#!/bin/bash

# Directory containing all init scripts. Those scripts need to be in a lexicographic order!
if [ -z "${INIT_DIR}"]
then
	echo "INIT_DIR not set! Trying to use ${PWD}/init as INIT_DIR"
	export INIT_DIR="${PWD}/init"
fi
# Check if INITDIR exists or is empty. If yes return error code 1.
if [ ! `ls -A ${INIT_DIR}` ]
then
	echo "empty (or does not exist)"
	return 1
fi

# Make every *.sh script executable. Doing this here prevents us of doing it in every Dockerfile based on this base image!
chmod +x ${INIT_DIR}/*.sh 

# Execute every executable file in IBNITDIR.
for SCRIPT in ${INIT_DIR}/*
do
	if [ -f ${SCRIPT} -a -x ${SCRIPT} ]
	then
		${SCRIPT}
	fi
done

# YAY! Everything worked! Return exit code 0!
return 0
