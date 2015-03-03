## This file is not completely ready yet but will give an admin most necessary commands

sudo docker build --no-cache=true --force-rm=true -t layersowncloud ./webapp-runtime/
sudo docker build --no-cache=true --force-rm=true -t layersownclouddata ./webapp-data/
sudo docker build --no-cache=true --force-rm=true -t layersowncloudinit ./webapp-init/
sudo docker build --no-cache=true --force-rm=true -t layersowncloudmysql ./webapp-mysql/

#will create Volume for /var/www/owncloud
sudo docker run -d --name layersownclouddata layersownclouddata

#Will install owncloud in /var/www/ownclod of volume
sudo docker run -d --volumes-from layersownclouddata layersowncloudinit

#will run owncloud
#STILL NEEDS TO BE LINKED TO DATABASE!
sudo docker run -it --volumes-from layersownclouddata -p 80:80 layersowncloud /bin/bash
