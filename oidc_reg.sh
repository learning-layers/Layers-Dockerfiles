
#!/bin/bash
if [ "$DYN_REG" == 0 ]; then
        echo "Client already registered, exiting..." && exit
fi

wget http://stedolan.github.io/jq/download/linux64/jq
chmod +x ./jq

i=0
while (( $(curl --write-out %{http_code} --silent --output /dev/null $LAYERS_API_URI/o/oauth2/) != 200 && $i < 12))
do sleep 5 && ((i++))
done

if [ $i -eq 12 ]; then
        echo "Connection to server timed out, exiting..." && exit
fi



OIDC_DATA=$(curl -X POST $OIDC_PROVIDER_URI/register -d \
"{
        'application_type':'web',
        'redirect_uris':[${REDIRECT_URIS}],
        'client_name':'${CLIENT_NAME}'
}" -H 'Content-Type: application/json' -v)



CLIENT_ID=$(echo $OIDC_DATA | ./jq '.client_id')
CLIENT_SECRET=$(echo $OIDC_DATA | ./jq '.client_secret')


sed -i "s#CLIENT_ID#${CLIENT_ID}#g" $CONF_FILE_LOC && \
sed -i "s#CLIENT_SECRET#${CLIENT_SECRET}#g" $CONF_FILE_LOC

rm ./jq*
