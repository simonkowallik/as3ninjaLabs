#!/usr/bin/env bash

# check if lab has changed in pull request / commit
# Lab dir has the same name as the circleci job
run_lab=false

for lab in $(git diff --name-only HEAD~1 | cut -d"/" -f1 | sort -u)
do
  if [[ $CIRCLE_JOB == $lab ]]
  then
    run_lab=true
    break
  fi
done
if [[ $run_lab == "false" ]]
then
  echo "$CIRCLE_JOB has no changes, no need to run CI. Skipping CI job."
  circleci-agent step halt
else
  echo "$CIRCLE_JOB has changes in the current PR/commit. Running CI job!"
fi
