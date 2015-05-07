#!/bin/bash

INITDIR="/opt/init/"

if [ ! `ls -A ${INITDIR}` ]
	then
		echo "empty (or does not exist)"
		return 1
fi
  
for SCRIPT in ${INITDIR}*
	do
		if [ -f $SCRIPT -a -x $SCRIPT ]
			then
				$SCRIPT
		fi
	done
