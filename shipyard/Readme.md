Shipyard is the component for (remote) administration of the Layers Box. 
We decided on it to add a Web UI to the Box. For more information, visit http://shipyard-project.com/docs/

This folder contains a Dockerfile only for the CLI component of Shipyard. 
The vanilla https://github.com/shipyard/shipyard-deploy container should be used for the rest of Shipyard's functionality:

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock shipyard/deploy [COMMAND] where

COMMAND = ( start | stop | restart| upgrade | remove )
