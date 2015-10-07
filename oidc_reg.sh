#!/bin/bash

wget http://stedolan.github.io/jq/download/linux64/jq
chmod +x ./jq
alias jq='./jq'


OIDC_DATA=$(curl -X POST $LAYERS_API_URI/o/oauth2/register -d \
"{
	'application_type':'web',
	'redirect_uris':[${REDIRECT_URIS}],
	'client_name':'${CLIENT_NAME}'
}" -H "Content-Type: application/json" -v)

CLIENT_ID=echo $OIDC_DATA | jq '.client_id' 
CLIENT_SECRET=echo $OIDC_DATA | jq '.client_secret'


sed -i "s#CLIENT_ID#${CLIENT_ID}#g" $CONF_FILE_LOC && \
sed -i "s#CLIENT_SECRET#${CLIENT_SECRET}#g" $CONF_FILE_LOC
