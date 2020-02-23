#!/usr/bin/env bash

# check AS3 Declaration files exist
if [[ ! -e Lab10X/101/AS3Declaration.yaml ]]
then
  echo "Cannot find file 'Lab10X/101/AS3Declaration.yaml', are you in the correct directory?"
  exit 1
fi
if [[ ! -e Lab10X/101/AS3Declaration.json ]]
then
  echo "Cannot find file 'Lab10X/101/AS3Declaration.json', are you in the correct directory?"
  exit 1
fi

# create temporary declaration files
old_as3d=$(mktemp existing_as3declaration.XXXXXXX.json)
new_as3d=$(mktemp new_as3declaration.XXXXXXXXXXXX.json)

# copy JSON AS3 Declaration to tempfile, which is used as a reference
cat Lab10X/101/AS3Declaration.json | jq -S . > $old_as3d

# convert the YAML AS3 Declaration to JSON and store it in the tempfile
cicd/yaml2json -f Lab10X/101/AS3Declaration.yaml | jq -S . > $new_as3d

# Test if the generated JSON differs from the stored AS3Declaration.json
diff -ruN $old_as3d $new_as3d >/dev/null

if [[ $? -ne 0 ]]
then
  # if the files differ, the exit code of diff will be non-zero
  echo -e "\e[91m* ERROR: Lab10X/101/AS3Declaration.yaml differs from Lab10X/101/AS3Declaration.json\e[39m"
  diff -ruN --color=always $old_as3d $new_as3d
  rm -f $old_as3d $new_as3d
  exit 1  # throw error, we expect the files to match
else
  # file are the same
  echo -e "\e[92m* PASS: Lab10X/101/AS3Declaration.yaml is equal to Lab10X/101/AS3Declaration.json\e[39m"
  rm -f $old_as3d $new_as3d
  exit 0
fi
