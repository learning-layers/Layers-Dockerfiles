# Layers-Dockerfiles
This repo contains all the basic Dockerfiles defining the individual Docker containers used in the Layers Box. The script `start.sh` deploys a Layers Box on any Docker-enabled system. The script `backup.sh` realizes a simple backup of all data containers being part of a Layers Box.

# Setup
1. clone the repository and install cocker-compose
2. Fill in the URL the Box will be reachable on in common.env
3. Create an ssl certificate for the host and put the certificate and key in the ./ssl folder. They have to be named HOSTNAME.key and HOSTNAME.pem
4. Fill in the OIDC Variables in mobsos-query-visualization/QVS.env and mobsos-survers/SURVEYS.env

# Starting the Layers Box
Run ```./start.sh```
This will shut down all running services, if any are running and then restart all services.
This will also destroy all containers and recreate them, so services will get updates.
A backup of the data volumes is automatically created with attic before the volumes are shut down and restored after containers are recreated.
These backups are stored in the directories of the respective services. Currently mysql-data/backup and openldap-data/backup

# Stopping the Layers Box
Run ```./stop.sh```
This shut make a backup of the data containers and shut down all containers

# Restart/Update the Layers Box
Run ```./restart.sh```
All services will be restarted and containers recreated.
