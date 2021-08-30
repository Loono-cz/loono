#!/usr/bin/env sh

set -e # exit on first failed commandset
set -x # print all executed commands to the log

if [ "$FCI_BUILD_STEP_STATUS" == "success" ]
then
   new_version=v$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER
   git tag $new_version
   git push --tags
fi
