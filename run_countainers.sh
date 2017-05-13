#!/usr/bin/sh

set -eux

errors_count=0

if [[ -z $PLEX_CLAIM ]]; then
	echo "Missing Plex claim in environment: run export PLEX_CLAIM=<PLEX_CLAIM>";
	errors_count=$((errors_count+1));
fi

if [[ -z $ROOT_PATH ]]; then
	echo "Missing root path in environment: run export ROOT_PATH=<ROOT_PATH>";
	errors_count=$((errors_count+1));
fi

if [[ $errors_count -gt 0 ]]; then
	echo "$errors_count error(s) found."
	exit 1
fi

sed -i".bak" "s:<PLEX_CLAIM>:$PLEX_CLAIM:g;s:<ROOT_PATH>:$ROOT_PATH:g" docker-compose.template
mv docker-compose.template docker-compose.yml
mv docker-compose.template.bak docker-compose.template
docker-compose up -d
