#!/usr/bin/env bash
### This is a super simple deployment script to "deploy" to hastebin.com

# script only accepts a single argument
if [[ "$#" != "1" ]]
then
  echo "use $0: [AS3DeclarationFile]"
  exit 1
fi

# AS3Declaration file is the first argument
AS3DeclarationFile=$1

# send AS3 Declaration artifact to AS3 Ninja API
response=$(cat $AS3DeclarationFile \
          | jq -c . \
          | curl -s https://hastebin.com/documents \
                 -HContent-Type:application/json \
                 -XPOST \
                 -d @-)

# -> response={"key":"obivajefir"}

# extract key from response, fail gracefully
hastekey=$(echo $response | jq '.key' || exit 0)
hastekey=${hastekey:1:-1}

# -> hastekey=obivajefir

# check if hasteky is set
if [[ "$hastekey" == "" ]]
then
  echo "ERROR: failed to DEPLOY AS3 Declaration to hastebin (hastebin error)."
  exit 0
else
  echo -e "AS3 Declaration: $AS3DeclarationFile\nDeployed to URL:\nhttps://hastebin.com/$hastekey\n"
fi
