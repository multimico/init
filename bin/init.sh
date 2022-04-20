#!/bin/bash

# ensure the proper directories
PWD=$( dirname "$(readlink -f "${BASH_SOURCE}")" )
CDIR=$(dirname $PWD)

# get MAC ADDR
NAME=

for IPADDR in $(ip addr | grep ether | sed -E "s/.*ether (\S+) brd.*$/\U\1/" | sed -E s/:/-/g)
do
    TNAME=$( yq ".host[] | select(.phys-macaddress == \"$IPADDR\").name" "${CDIR}/config/hardware.yaml" )

    if [ ! -z $TNAME ]
    then
        NAME=$TNAME
    fi
done

if [ -z $NAME ]
then
    echo "No host name found for MAC Address!"
    exit 1
fi

BOOTSTRAP_REPO=$( yq "select(.host[] | contains(\"$NAME\") and .active).repo" "${CDIR}/config/bootstrap_repos.yaml" )

if [ -z $BOOTSTRAP_REPO ]
then
    echo "No repo URL found for host!"
    exit 1
fi

# The bootstrap path is globally created 
git clone "$BOOTSTRAP_REPO" /run/multimico/bootstrap

bash /run/multimico/init/bin/init.sh
