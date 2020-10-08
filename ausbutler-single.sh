#!/bin/bash
set -eu
TOURNAMENT=$1
cd "$(dirname "$0")"

echo "Processing $TOURNAMENT..."

set -o allexport
source configs/_common.env
source configs/$TOURNAMENT.env
set +o allexport

ls config.template | while read CONFIGFILE
do
    envsubst < config.template/$CONFIGFILE > config/$CONFIGFILE
done

python jfrteamy-ausbutler/butler.py calculate generate nowait

lftp -f config/send.lftp

echo "Done"
