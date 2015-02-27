# mysql
This repo contains the MySQL server Dockerfile of the Learning Layers project.

To start it, call
`docker run -d -e MYSQL_ROOT_PASSWORD=pass --volumes-from=learninglayers/mysql-data learninglayers/mysql`
