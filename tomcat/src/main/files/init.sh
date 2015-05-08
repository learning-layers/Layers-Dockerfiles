#!/bin/bash

# Directory containing all init scripts. Those scripts need to be in a lexicographic order!
INITDIR="/opt/init"

# Check if INITDIR exists or is empty. If yes return error code 1.
if [ ! `ls -A ${INITDIR}` ]
	then
		echo "empty (or does not exist)"
		return 1
fi

# Make every *.sh script executable. Doing this here prevents us of doing it in every Dockerfile based on this base image!
chmod +x ${INITDIR}/*.sh 

# Execute every executable file in IBNITDIR.
for SCRIPT in ${INITDIR}/*
	do
		if [ -f $SCRIPT -a -x $SCRIPT ]
			then
				$SCRIPT
		fi
	done

# YAY! Everything worked! Return exit code 0!
return 0
