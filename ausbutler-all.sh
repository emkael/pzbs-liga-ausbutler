#!/bin/bash
set -eu
cd "$(dirname "$0")"
grep -v '^#' tournaments.txt | while read -r TOURNAMENT
do
    ./ausbutler-single.sh $TOURNAMENT
done
