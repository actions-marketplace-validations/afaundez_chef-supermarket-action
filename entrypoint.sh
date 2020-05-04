#!/bin/sh -l

USER_KEY='/tmp/${USER}.pem';
cat ${KEY} > ${USER_KEY};

GITHUB_OWNER=$(echo ${GITHUB_REPOSITORY} | cut -f1 -d/);
GITHUB_PROJECT=$(echo ${GITHUB_REPOSITORY} | cut -f2 -d/);

if [ -z '${USER}' ]; then
    USER='${GITHUB_OWNER}';
    echo 'Patching user with ${USER}.';
fi;

if [ -z '${COOKBOOK}' ]; then
    COOKBOOK=$(echo '${GITHUB_PROJECT}' | sed -e 's/-cookbook$//');
    echo 'Patching cookbook with ${COOKBOOK}.';
fi;

cd ${GITHUB_WORKSPACE};

knife --user=${USER} --key=${USER_KEY}.pem supermarket share ${COOKBOOK} ${CATEGORY};
