#!/bin/bash

rm -rf preview-docs
rm -rf stable-docs
rm preview-docs.zip
rm stable-docs.zip

LINUX_PREVIEW_LATEST=`curl -s 'https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/versions.json' | jq -r '.linux.preview'`
LINUX_PREVIEW="https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/linux_preview/$LINUX_PREVIEW_LATEST.json"

LINUX_STABLE_LATEST=`curl -s 'https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/versions.json' | jq -r '.linux.stable'`
LINUX_STABLE="https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/linux/$LINUX_STABLE_LATEST.json"

## Preview
LINUX_DOWNLOAD_URL=`curl -s $LINUX_PREVIEW | jq -r '.download_url'`
echo "Minecraft v$LINUX_PREVIEW_LATEST - $LINUX_DOWNLOAD_URL"

wget $LINUX_DOWNLOAD_URL -q -O bds.zip
unzip bds.zip -d bds

rm bds.zip
cd bds

echo '{ "generate_documentation": true }' > 'test_config.json'
./bedrock_server

mv docs ../preview-docs
cd ..
rm -r bds

## Stable
DOWNLOAD_URL=`curl -s $LINUX_STABLE | jq -r '.download_url'`
echo "Minecraft v$LINUX_STABLE_LATEST - $DOWNLOAD_URL"

wget $DOWNLOAD_URL -q -O bds.zip
unzip bds.zip -d bds

rm bds.zip
cd bds

echo '{ "generate_documentation": true }' > 'test_config.json'
./bedrock_server

mv docs ../stable-docs
cd ..
rm -r bds

## Zip files
# cd preview-docs
# zip preview-docs.zip -r .
# mv preview-docs.zip ../preview-docs.zip
# cd ..

# cd stable-docs
# zip stable-docs.zip -r .
# mv stable-docs.zip ../stable-docs.zip
# cd ..
