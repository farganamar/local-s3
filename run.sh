#!/bin/bash

OS_RAW=`uname -s`
ARCH_RAW=`uname -m`
OS="$(tr '[:upper:]' '[:lower:]' <<< $OS_RAW)"
ARCH="$(tr '[:upper:]' '[:lower:]' <<< $ARCH_RAW)"
USER=`whoami`
MIN_IO_VERSION="${OS}-${ARCH}"

if [ $MIN_IO_VERSION == "darwin-x86_64" ]
then
    URL_DOWNLOAD="https://dl.min.io/server/minio/release/darwin-amd64/minio"
else
    URL_DOWNLOAD="https://dl.min.io/server/minio/release/${MIN_IO_VERSION}/minio"
fi

if [ ! -f "minio" ]; then
  wget "${URL_DOWNLOAD}";
fi

chmod +x minio
chmod u+rxw ./data
chown -R ${USER} ./data

export MINIO_ROOT_USER="root"
export MINIO_ROOT_PASSWORD="password"

./minio server ./data --console-address "localhost:60101" --address "localhost:9291"
