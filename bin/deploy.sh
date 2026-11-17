#!/bin/bash

echo "Starting script..."
set -x

git pull
hugo build --cleanDestinationDir
rm -rf /data/app/nginx/posts/*
cp -a public/* /data/app/nginx/posts/

set +x
echo "Script completed."
