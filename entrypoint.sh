#!/bin/sh -l

USER_KEY="/tmp/${USER}.pem";
echo ${KEY} > ${USER_KEY};

GITHUB_OWNER=$(echo ${GITHUB_REPOSITORY} | cut -f1 -d/);
GITHUB_PROJECT=$(echo ${GITHUB_REPOSITORY} | cut -f2 -d/);

echo "GITHUB_OWNER: ${GITHUB_OWNER}";
echo "GITHUB_PROJECT: ${GITHUB_PROJECT}";

if [ -z "${USER}" ]; then
    USER="${GITHUB_OWNER}";
    echo "Patching USER with ${USER}.";
fi;

if [ -z "${COOKBOOK}" ]; then
    COOKBOOK=$(echo "${GITHUB_PROJECT}" | sed -e "s/-cookbook$//");
    echo "Patching COOKBOOK with ${COOKBOOK}.";
fi;

COOKBOOK_PATH=$(dirname "${GITHUB_WORKSPACE}");
echo "COOKBOOK_PATH: ${COOKBOOK_PATH}";

echo "Sharing '${COOKBOOK}' with user '${USER}'";
cd ${GITHUB_WORKSPACE};
knife supermarket share "${COOKBOOK}" "${CATEGORY}" --user="${USER} "--key="${USER_KEY}.pem" --cookbook-path="${COOKBOOK_PATH}";
