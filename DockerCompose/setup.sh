#!/bin/bash

function copyfile () {
    echo "--->: cp -f $1 $2"
    if [ -e $2 ];then
        rm -f $2;
    fi
    cp -f $1 $2
}
function copyrfile () {
    echo "--->: cp -f $1 $2"
    if [ -d $2 ];then
        rm -Rf $2;
    fi
    cp -Rf $1 $2
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
bincount=$(ls ./var/docker/bin/*|wc -l)
if [ $bincount -gt 0 ];then
    for _bin in $(ls ./var/docker/bin/*); do
        copyfile $_bin /usr/local/bin/$(basename ${_bin})
        chmod a+x /usr/local/bin/$(basename $_bin)
    done
    copyfile ./var/docker/bin/dockercomposer /etc/init.d/dockercomposer
    chmod a+x /etc/init.d/dockercomposer
fi

# Docker-Compose FIles
ymlcount=$(ls ./var/docker/compose/*.yml|wc -l)
if [ $ymlcount -gt 0 ];then
    for _yml in $(ls ./var/docker/compose/*.yml); do
        _host=$(hostname)
        if [ "${_host:0:3}" = "${_yml:0:3}" ]; then
            copyfile ${_yml} /var/docker/compose/$(basename ${_yml})
        fi
    done
fi
