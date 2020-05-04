#!/bin/sh -l

GITHUB_OWNER=$(echo "${GITHUB_REPOSITORY}" | cut -f1 -d/);
echo "GITHUB_OWNER: ${GITHUB_OWNER}";
if [ -z "${USER}" ]; then
  USER="${GITHUB_OWNER}";
  echo "Patching USER with ${USER}.";
fi;

GITHUB_PROJECT=$(echo "${GITHUB_REPOSITORY}" | cut -f2 -d/);
echo "GITHUB_PROJECT: ${GITHUB_PROJECT}";
if [ -z "${COOKBOOK}" ]; then
  COOKBOOK=$(echo "${GITHUB_PROJECT}" | sed -e "s/-cookbook$//" | sed -e "s/-/_/");
  echo "Patching COOKBOOK with ${COOKBOOK}.";
fi;

echo "GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}";
COOKBOOK_PATH=$(dirname "${GITHUB_WORKSPACE}");
echo "COOKBOOK_PATH: ${COOKBOOK_PATH}";

echo "Sharing '${COOKBOOK}' with user '${USER}'";
cd ${GITHUB_WORKSPACE};

USER_KEY="/tmp/${USER}.pem";
echo ${SUPERMARKET_API_KEY} > ${USER_KEY};
chmod 600 ${USER_KEY};

CONFIG_PATH="/tmp/config.rb";
touch ${CONFIG_PATH};
echo "node_name \"${USER}\"" >> ${CONFIG_PATH};
echo "client_key \"${USER_KEY}\"" >> ${CONFIG_PATH};
echo "cookbook_path [ \"${COOKBOOK_PATH}\" ]" >> ${CONFIG_PATH};
echo "source_url \"https://github.com/${GITHUB_REPOSITORY}\"" >> ${CONFIG_PATH};
echo "issues_url \"https://github.com/${GITHUB_REPOSITORY}/issues\"" >> ${CONFIG_PATH};

knife supermarket share "${COOKBOOK}" "${CATEGORY}" --config="${CONFIG_PATH}";
