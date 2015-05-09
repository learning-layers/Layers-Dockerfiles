# Tomcat Docker Base Image
This repo contains the Tomcat Dockerfile of the Learning Layers project that should be used by all Java-based Web application containers.

This base image also introduces an automatic way of initialising a container with src/main/files/init.sh.
This script executes all scripts in a given directory. As default you need to place them into /opt/init.
There are three defaults scripts:
00_env.sh - This script just prints all environment variables
50_tomcat.sh - This script starts tomcat.
99_log.sh - This script is following all changes in the catalina.out log.

You can change any of those scripts or add new scripts with any image based on this image. To do this there is also a best-practise skeleton script named ##_script.sh.skeleton.
Please just stick to the policy in src/main/files/init/README.

#### Contact
Gordon Lawrenz (lawrenz<ät>dbis.rwth-aachen.de)
