#!/bin/sh
# Reassemble the MR12.8 distribution tapes into ./unpacked/
# (files over GitHub's 100 MB limit are stored split in this directory).
set -eu
cd "$(dirname "$0")"
mkdir -p unpacked
cat MR12.8_artifacts.zip.part-* > unpacked/MR12.8_artifacts.zip
cat 12.8LISTINGS.tap.xz.part-* | xz -dc > unpacked/12.8LISTINGS.tap
(cd unpacked && sha256sum -c ../SHA256SUMS && unzip -oqj MR12.8_artifacts.zip && rm MR12.8_artifacts.zip)
echo "Tapes are in $(pwd)/unpacked"
echo "Cold boot a new system there with:  ../../../bin/dps8 MR12.8_coldboot.ini"
