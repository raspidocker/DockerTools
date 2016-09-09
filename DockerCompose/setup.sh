#!/bin/bash

function copyfile () {
    echo "--->: cp -f $1 $2"
    cp -f $1 $2
}
function link () {
    if [ -h $2 ]; then
        echo "--->: rm -f $2"
        rm -f $2
    fi
    echo "--->: ln -s $1 $2"
    ln -s $1 $2
}
echo "Copy source from local-repository to target"
copyfile ./etc/init.d/dockercomposer /etc/init.d/dockercomposer
link /etc/init.d/dockercomposer /usr/local/bin/
copyfile ./var/docker/compose/$(hostname)-*.yml /var/docker/compose/