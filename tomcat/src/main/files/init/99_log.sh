#!/bin/bash

# Follow "catalina.out"! This task should never end so the container can't exit!
echo ""
echo "Follow ${TOMCAT_HOME}/logs/catalina.out:"
tail -f ${TOMCAT_HOME}/logs/catalina.out
