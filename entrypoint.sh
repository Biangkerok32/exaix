#!/bin/sh -l

set -eu

apt-get update && apt-get install -y \
  ant \
  git \
  openjdk-8-jdk

git clone $1
git submodule update --init

cp -r src/** exai/appinventor/components/src

cd exai/appinventor/
ant clean
ant MakeAuthKey
ant extensions -Dproguard=1

cd ../..

cd exai/appinventor/components/build/extensions
file=$(dir)
echo ::set-output name=file::$file

cd ../../../../..
