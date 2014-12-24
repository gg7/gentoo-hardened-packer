#!/bin/bash
# vi: set et ts=2 sw=2 :

set -o errexit  # Exit on any errors
set -o nounset  # Trigger an error when expanding unset variables

cd "${BASH_SOURCE%/*}"/downloads || exit 1

BASE_URL="http://distfiles.gentoo.org/releases/amd64/autobuilds"

LATEST_ISO_RELATIVE_URL=$(curl --silent "$BASE_URL/latest-iso.txt" | grep '\.iso$')
LATEST_ISO_URL="$BASE_URL/$LATEST_ISO_RELATIVE_URL"
wget --timestamping "$LATEST_ISO_URL"
find . -type f -name 'install-amd64-minimal-*.iso' -not -newer "$(basename "$LATEST_ISO_URL")" -not -name "$(basename "$LATEST_ISO_URL")"

ISO_DIGESTS_SIGNED="$LATEST_ISO_URL.DIGESTS.asc"
wget --timestamping "$ISO_DIGESTS_SIGNED"

gpg --quiet --verify "$(basename "$ISO_DIGESTS_SIGNED")" || exit 1

SHA512SUM=$(sha512sum "$(basename "$LATEST_ISO_URL")" | grep -Po '^[0-9a-f]{128}')

grep --quiet -- "$SHA512SUM"  "$(basename "$ISO_DIGESTS_SIGNED")" || exit 1

LATEST_STAGE3_URL_URL="$BASE_URL/latest-stage3-amd64-hardened+nomultilib.txt"
LATEST_STAGE3_RELATIVE_URL=$(curl --silent "$LATEST_STAGE3_URL_URL" | grep '\.tar\.')
LATEST_STAGE3_URL="$BASE_URL/$LATEST_STAGE3_RELATIVE_URL"

wget --timestamping "$LATEST_STAGE3_URL"

STAGE3_DIGESTS_SIGNED="$LATEST_STAGE3_URL.DIGESTS.asc"
wget --no-verbose --timestamping "$STAGE3_DIGESTS_SIGNED"

gpg --quiet --verify "$(basename "$STAGE3_DIGESTS_SIGNED")" || exit 1

cd ..

PASSWORD=$(cat meta/password | grep '.*')

cat meta/gentoo-hardened.json \
  | sed "s/<iso_file>/.\/downloads\/$(basename "$LATEST_ISO_URL")/" \
  | sed "s/<iso_checksum>/$SHA512SUM/" \
  | sed "s/<stage3_file>/.\/downloads\/$(basename "$LATEST_STAGE3_URL")/" \
  | sed "s/<stage3_tarball>/$(basename "$LATEST_STAGE3_URL")/" \
  | sed "s/<password>/$PASSWORD/" \
  > gentoo-hardened-latest.json

echo
echo success
