#!/bin/bash

URL='http://localhost:8080'
USER='test:tester'
KEY='testing'

## ISsUE CURL AND SAVE HEADERS
echo -e "Get Token\n"
while IFS=':' read key value; do
  value=$(echo $value | sed -e 's/^[[:space:]]*//' |   sed -e 's/\r//g')

  case "$key" in
    "")
      ;;
    "HTTP/1.1"*)
      HTTP="$key"
      echo "$HTTP"
      ;;
    "X-Auth-Token")
      TOKEN="$value"
      echo "$key: $value"
      ;;
    "X-Storage-Url")
      echo "WHAT"
      XURL="$value"
      echo "$key: $value"
      ;;
    *)
      echo "$key: $value"
      ;;
  esac

done < <(curl -s -i -H "X-Auth-User: $USER" -H "X-Auth-Key: $KEY" "$URL/auth/v1.0" | head -n -1)
echo ""

if [[ "$HTTP" != "HTTP/1.1 200 OK"* ]]; then
  echo "DAMN! WHAT HAPPENED!?"
  exit 1;
fi

echo -e "\n\nCreate container"
curl -v -X PUT -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer"

echo -e "\n\nList containers"
curl -v -X GET -H "X-Auth-Token: $TOKEN" "$XURL"

echo -e "\n\nContents of container"
curl -v -X GET  -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer"

echo -e "\n\nMetadata of container"
curl -v -X HEAD -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer"

echo -e "\n\nPut object"
curl -v -X PUT -H "X-Auth-Token: $TOKEN" -d "HAHA" "$XURL/testcontainer/testobject"

echo -e "\n\nRetrieve object"
curl -v -X GET -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer/testobject"

echo -e "\n\nDelete Everything Deployed with Script"
curl -v -X DELETE -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer/testobject"
curl -v -X DELETE -H "X-Auth-Token: $TOKEN" "$XURL/testcontainer"

echo -e "\n\nEnded test"
