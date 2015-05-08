#!/bin/bash

echo "Processing $0"
echo "Follow ${TOMCAT_HOME}/logs/catalina.out:"

# Follow "catalina.out"! This task should never end so the container can't exit!
tail -f ${TOMCAT_HOME}/logs/catalina.out

echo ""
