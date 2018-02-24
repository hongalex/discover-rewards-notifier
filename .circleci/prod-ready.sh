#!/usr/bin/env bash

# Replaces fields in manifest.json based on the current git tag

# DO NOT edit this file on Windows. It will cause CRLF line endings, which will fail on CircleCI.
# If you do edit on Windows, use `dos2unix` before you commit.

# If there is no tag, the script will have non-0 exit code
GIT_TAG=$(git describe --exact-match --tags HEAD)
if [ ! $? -eq 0 ]; then
  echo "This commit doesn't have a tag, skip setting the version."
  exit 0
fi

echo "Found a tag $GIT_TAG"
VERSION_NUM=$( echo ${GIT_TAG} | cut -c 2- )

jq '.version = '"\"${VERSION_NUM}\"" ./manifest.json | sponge ./manifest.json
echo "Version set to $(jq '.version' ./manifest.json)"

jq '.version_name = '"\"${GIT_TAG}\"" ./manifest.json | sponge ./manifest.json
echo "Version Name set to $(jq '.version_name' ./manifest.json)"
