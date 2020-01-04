#!/bin/bash
set -eu
cd "$(dirname "$0")"
while read -r TOURNAMENT
do
    ./ausbutler-single.sh $TOURNAMENT
done < tournaments.txt
