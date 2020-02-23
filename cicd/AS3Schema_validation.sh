#!/usr/bin/env bash

# script only accepts a single argument
if [[ "$#" != "1" ]]
then
  echo "use $0: [AS3DeclarationFile]"
  exit 1
fi

# AS3Declaration file is the first argument
AS3DeclarationFile=$1

echo "POSTing AS3 Declaration to: http://localhost:8000/api/schema/validate for validation."

# send AS3 Declaration artifact to AS3 Ninja API
response=$(curl -s http://localhost:8000/api/schema/validate \
             -XPOST \
             -HContent-Type:application/json \
             -d @$AS3DeclarationFile)

# print response for debugging
echo "Raw AS3 Ninja API response:"
echo "---------------------------"
echo $response | jq . 2>/dev/null || echo $response
echo

# check that response says AS Declaration is valid (valid==true) or exit with an error
if [[ $(echo $response | jq '.valid') == true ]]
then
  echo -e "\e[92m* PASS: The AS3 Declaration ($AS3DeclarationFile) complies with the latest AS3 Schema.\e[39m"
else
  echo -e "\e[91m* FAIL: The AS3 Declaration ($AS3DeclarationFile) doesn't comply with the latest AS3 Schema.\e[39m"
  exit 1
fi
