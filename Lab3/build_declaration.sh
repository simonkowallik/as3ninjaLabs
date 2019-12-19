#!/usr/bin/env bash
# script to build the AS3 Declaration

file_prefix=$(basename $PWD)
echo $file_prefix
if [[ "$file_prefix" == "Lab3" ]]
then
  file_prefix="./"
else
  file_prefix="Lab3"
fi

set -v

# set ARTIFACT env var if it isn't
ARTIFACT=${ARTIFACT:-${file_prefix}/AS3Declaration.json}

# as3ninja command to built the declaration
# This requires a local install of AS3 Ninja
as3ninja transform \
  --no-validate \
  -c $file_prefix/mappings.yaml \
  -c $file_prefix/ninja.yaml \
  -c $file_prefix/siteA.yaml \
  -t $file_prefix/template.jinja2 \
  -o $ARTIFACT
