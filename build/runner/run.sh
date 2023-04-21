#!/usr/bin/env bash
set -e

if [ $(id -un) != runner ]; then
  sudo -u runner -EH ${0} "${@}"
  exit 0
fi

user_login=$(curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/user" | jq -r ".login")

echo "Logged in with the account @${user_login} ..."

for org_login in $(curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/user/orgs" | jq -r ".[].login"); do
  echo "Registering as a runner with the organization @${org_login} ..."
  registraton_token=$(curl -s -X POST -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/orgs/${org_login}/actions/runners/registration-token" | jq -r ".token")
  echo "Registering runner with token ${registraton_token} ..."
  ~/config.sh --unattended --url "https://github.com/${org_login}" --pat "${GITHUB_TOKEN}" --check
  ~/config.sh --unattended --url "https://github.com/${org_login}" --token "${registraton_token}" --labels "$(hostname | sed -E 's/\-[0-9]+//')" --ephemeral --replace
done

~/run.sh "${@}"
