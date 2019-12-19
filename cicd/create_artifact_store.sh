#!/usr/bin/env bash

# script only accepts a single argument
if [[ "$#" != "1" ]]
then
  echo "use $0: [AS3DeclarationFile]"
  exit 1
fi

# artifact directory is first argument
artifacts_dir=$1

# create an artifact directory for each Lab
for lab in $(find . -maxdepth 1 -type d | grep /Lab | sort -u)
do
  lab=$(basename $lab)
  if [[ $lab =~ "Lab" ]]
  then
    echo "creating: ${artifacts_dir}/$lab"
    mkdir -p ${artifacts_dir}/$lab
  fi
done
