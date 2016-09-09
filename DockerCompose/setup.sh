#!/bin/bash

function copyfile () {
    echo "--->: cp -f $1 $2"
    cp -f $1 $2
}
function link () {
    if [ -e $2 ]; then
        echo "--->: rm -f $2"
        rm -f $2
    fi
    echo "--->: ln -s $1 $2"
    ln -s $1 $2
}
echo "Copy source from local-repository to target"


# Binary & init.d Files
for _bin in $(ls ./var/docker/bin/*); do
    link $_bin /usr/local/bin/$(basename $_bin)
    chmod a+x /usr/local/bin/$(basename $_bin)
done
copyfile ./var/docker/bin/dockercomposer /etc/init.d/dockercomposer
chmod a+x /etc/init.d/dockercomposer


# Docker-Compose FIles
for _yml in $(ls ./var/docker/compose/$(hostname)-*.yml); do
    copyfile $_yml /var/docker/compose/
done

