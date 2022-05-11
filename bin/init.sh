#!/bin/bash

# ensure the proper directories
# PWD=$( dirname "$(readlink -f "${BASH_SOURCE}")" )
CDIR="/run/multimico/init"

# move yq into place
wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
chmod a+x /usr/local/bin/yq

# get MAC ADDR
NAME=

for IPADDR in $(ip addr | grep ether | sed -E "s/.*ether (\S+) brd.*$/\U\1/" | sed -E s/:/-/g)
do
    TNAME=$( yq ".host[] | select(.phys-macaddress == \"${IPADDR}\").name" "${CDIR}/config/hardware.yaml" )

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

MACADDRESS=$( yq ".host[] | select(.phys-macaddress == \"${IPADDR}\").macaddress" "${CDIR}/config/hardware.yaml" )

BOOTSTRAP_REPO=$( yq ".[] | select(.host[] | contains(\"$NAME\") and .active).repo" "${CDIR}/config/bootstrap_repos.yaml" )

if [ -z $BOOTSTRAP_REPO ]
then
    echo "No repo URL found for host!"
    exit 1
fi

# The bootstrap path is globally created 
mkdir -p /run/multimico/bootstrap


echo "Pass $(echo $MACADDRESS | sed -E s/-/:/g) to sub init script"

git clone "$BOOTSTRAP_REPO" /run/multimico/bootstrap && \
    bash /run/multimico/bootstrap/bin/init.sh $(echo $MACADDRESS | sed -E s/-/:/g)
