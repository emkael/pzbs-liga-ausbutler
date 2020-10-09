#!/bin/bash
set -eu
TOURNAMENT=$1
cd "$(dirname "$0")"

echo "Processing $TOURNAMENT..."

mkdir -p config

set -o allexport
source configs/_common.env
source configs/$TOURNAMENT.env
set +o allexport

ls config.template | while read CONFIGFILE
do
    envsubst < config.template/$CONFIGFILE > config/$CONFIGFILE
done

mkdir -p ${LIGA_AUSBUTLER_OUTPUT_PATH}

python jfrteamy-ausbutler/butler.py calculate generate nowait

if command -v lftp &> /dev/null
then
    if [ -z ${LIGA_AUSBUTLER_FTP_ENABLED+x} ]
    then
        :
    else
        lftp -f config/send.lftp
    fi
fi

rm config/*

echo "Done"
