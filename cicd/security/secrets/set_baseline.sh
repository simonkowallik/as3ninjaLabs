#!/usr/bin/env bash

# save 'allowed' secrets as baseline
# ideally this file is empty (no embeded secrets)
_date=$(date +%s)
detect-secrets scan | jq '.results | del(.|.["secrets.baseline.json"])' > ${_date}_secrets.baseline.json

if [[ -f secrets.baseline.json ]]
then
  diff secrets.baseline.json ${_date}_secrets.baseline.json >/dev/null
  if [[ $? -ne 0 ]]
  then
    echo -e "\e[93m* INFO: Secrets baseline has changed.\e[39m"
  else
    echo -e "\e[92m* INFO: No changes to secrets baseline detected.\e[39m"
  fi
else
  echo -e "\e[93m* INFO: Secrets baseline set.\e[39m"
fi
mv -f ${_date}_secrets.baseline.json secrets.baseline.json
