#!/bin/bash
set -eu
TOURNAMENT=$1
cd "$(dirname "$0")"

echo "Processing $TOURNAMENT..."

ln -sfn configs/config.$TOURNAMENT config
python jfrteamy-ausbutler/butler.py calculate generate nowait

echo "Done"
