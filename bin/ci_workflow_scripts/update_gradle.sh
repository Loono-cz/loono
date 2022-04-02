#!/usr/bin/env sh

sed -i -e '/start remove first/,+16d;' ./android/app/build.gradle
cat ./android/app/build.gradle