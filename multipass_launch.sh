#!/bin/bash

echo "Initializing Maganger Node"
multipass launch --name manager --network en7 --cloud-init ./cloud-init.yaml
echo "Initializing Worker1 Node"
multipass launch --name worker1 --network en7 --cloud-init ./cloud-init.yaml
echo "Initializing Worker2 Node"
multipass launch --name worker2 --network en7 --cloud-init ./cloud-init.yaml


echo "Initializing docker swarm on manager"
ADDR=$(multipass exec manager -- ip address show to 10.40.60.0/24 | awk -F"inet " '{split($2,a,"/"); print a[1]}')
echo "Binding to $ADDR"
multipass exec manager -- docker swarm init --advertise-addr $ADDR
echo "Getting worker node joing token and configuring nodes"
JOIN_COMMAND=$(multipass exec manager -- docker swarm join-token worker | awk 'NR==3{sub(/^[ \t]+/,""); print }')
multipass exec worker1 -- eval $JOIN_COMMAND
multipass exec worker2 -- eval $JOIN_COMMAND
./multipass_verify.sh