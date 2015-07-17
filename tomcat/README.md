# Tomcat Docker Base Image
#### What is it's use
This repo contains the Tomcat Dockerfile of the Learning Layers project that should be used by all Java-based Web application containers.

#### How to use it
Just place your war file inside ${TOMCAT_HOME}/webapps and run the container.

This base image also introduces an automatic way of initialising a container with src/main/files/init.sh.
This script executes all scripts in a given directory. As default you need to place them into /opt/init.
There are three defaults scripts:
00_env.sh - This script just prints all environment variables
50_tomcat.sh - This script starts tomcat.
99_log.sh - This script is following all changes in the catalina.out log.

You can change any of those scripts or add new scripts with any image based on this image. To do this there is also a best-practise skeleton script named ##_script.sh.skeleton.
Please just stick to the policy in src/main/files/init/README.

#### ENV you can use with this Image

INSTALL_DIR="/opt"
INIT_SH="${INSTALL_DIR}/init.sh"
INIT_DIR="${INSTALL_DIR}/init"
JAVA_HOME="/usr/lib/jvm/java-8-oracle"
TOMCAT_HOME="${INSTALL_DIR}/tomcat"

#### Contact
Gordon Lawrenz (lawrenz<ät>dbis.rwth-aachen.de)
