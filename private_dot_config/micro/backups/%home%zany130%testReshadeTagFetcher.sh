#!/usr/bin/env bash

GHURL="https://github.com"
WGET="wget"

function fetchGitHubTags {
    PROJURL="$1"
    N="$2"

    RELEASESURL="${PROJURL}/releases"
    TAGSURL="${PROJURL}/tags"

    TAGSGREP="${RELEASESURL#"$GHURL"}/tag"

    mapfile -t BASETAGS < <("$WGET" -q "${TAGSURL}" -O - 2> >(grep -v "SSL_INIT") | grep -oE "${TAGSGREP}[^\"]+" | sort -urV | grep -m "$N" "$TAGSGREP")
    for TAG in "${BASETAGS[@]}"; do
        basename "$TAG"
    done
}

RESHADETAGS="$( fetchGitHubTags "https://github.com/crosire/reshade" "5" )"
RESHADETAGS="${RESHADETAGS//$'\n'/!}"
RESHADETAGS="${RESHADETAGS//v/}"

echo "${RESHADETAGS}"
