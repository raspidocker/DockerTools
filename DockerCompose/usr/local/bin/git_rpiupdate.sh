#!/bin/bash

REPO_BASE=/var/docker/build
REPOS="DockerImages DockerTools"
git_pass=${1:$ENV_GITPASS}
git_user=raspidocker
git_url=github.com/${git_user}

for r in ${REPOS}; do
        REPO_L=${REPO_BASE}/${r}
        if [ ! -d $REPO_L ]; then
                echo "Clone Repo $REPO_L"
                cd ${REPO_BASE}
                if [ "$git_pass" = "" ]; then
                    git clone https://${git_url}/${r}
                else
                    git clone https://${git_user}:${git_pass}@${git_url}/${r}
                fi
        else
                echo "Update Repo $REPO_L"
                cd ${REPO_L}
                git pull
        fi
done

exit 0