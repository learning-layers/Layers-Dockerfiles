## This file is not completely ready yet but will give an admin most necessary commands

sudo docker build --no-cache=true --force-rm=true -t layersowncloud ./webapp-runtime/
sudo docker build --no-cache=true --force-rm=true -t layersownclouddata ./webapp-data/
sudo docker build --no-cache=true --force-rm=true -t layersowncloudmysql ./webapp-mysql/

#will create Volume for /var/www/owncloud with owncloud installation
sudo docker run -d --name layersownclouddata layersownclouddata

#will run owncloud
#STILL NEEDS TO BE LINKED TO DATABASE!
sudo docker run -d --volumes-from layersownclouddata -p 80:80 --name layersowncloud layersowncloud
