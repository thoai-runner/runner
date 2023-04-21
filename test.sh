#!/usr/bin/env bash
set -euo pipefail

for item in "${@}"; do
  p1=($(echo ${item} | sed -E 's/([a-z\.-]+)\/(.+)$/\1 \2/'))
  p2=($(echo ${p1[1]} | sed -E 's/(.+):([a-z]+)$/\1 \2/'))
  token=$(cat ~/.docker/config.json | jq -r "$(printf '.auths."%s".auth' ${p1[0]})")
  pull_token=$(curl -sL "https://${p1[0]}/token?service=registry.docker.io&scope=repository:${p2[0]}:pull" -H "Authorization: Basic ${token}" | jq -r .token)
  manifests="$(curl -sL "https://${p1[0]}/v2/${p2[0]}/manifests/${p2[1]}" -H "Authorization: Bearer ${pull_token}" -H 'Accept: application/vnd.oci.image.index.v1+json' | jq -r .)"
  # echo "${manifests}" | jq -r .
  echo "${manifests}" | jq -r '.manifests[] | tojson' | while read -r line; do
    # echo "${line}" | jq -r .
    curl -sL "https://${p1[0]}/v2/${p2[0]}/blobs/$(echo "${line}" | jq -r .digest)" -H "Authorization: Bearer ${pull_token}" -H "Accept: $(echo "${line}" | jq -r .mediaType)"; done
done
