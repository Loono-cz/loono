#!/usr/bin/env sh

sed -i -e '/start remove first/,+16d;' ./android/app/build.gradle
sed -i -e '/start remove second/,+1d;' ./android/app/build.gradle
sed -i -e '/end remove second/,+1d;' ./android/app/build.gradle
