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
copyfile ./etc/init.d/dockercomposer /etc/init.d/dockercomposer
link /etc/init.d/dockercomposer /usr/local/bin/dockercomposer
copyfile ./var/docker/compose/$(hostname)-*.yml /var/docker/compose/

for _bin in $(ls ./var/docker/bin/*); do
    link $_bin /usr/local/bin/$(basename $_bin)
    chmod a+x /usr/local/bin/$(basename $_bin)
done
