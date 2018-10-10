#!/bin/bash
cd "$(dirname "$0")"
while read -r TOURNAMENT
do
    ln -sfn configs/config.$TOURNAMENT config
    python jfrteamy-ausbutler/butler.py calculate generate nowait
done < tournaments.txt
