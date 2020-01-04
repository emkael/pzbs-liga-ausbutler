#!/bin/bash
set -eu
TOURNAMENT=$1
cd "$(dirname "$0")"

echo "Processing $TOURNAMENT..."
echo ""

ln -sfn configs/config.$TOURNAMENT config
python jfrteamy-ausbutler/butler.py calculate generate nowait

echo ""
echo "Done"
echo ""
