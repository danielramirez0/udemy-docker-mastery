#!/bin/bash

echo "Creating overlay networks"
multipass exec manager -- docker network create --driver overlay backend
multipass exec manager -- docker network create --driver overlay frontend

echo "Creating vote service"
multipass exec manager -- docker service create --name vote -p 80:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote

echo "Creating redis service"
multipass exec manager -- docker service create --name redis --network frontend redis:3.2

echo "Creating worker service"
multipass exec manager -- docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker

echo "Creating postgres service"
multipass exec manager -- docker service create --name postgres --network backend -e POSTGRES_HOST_AUTH_METHOD=trust --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

echo "Creating result service"
multipass exec manager -- docker service create --name result -p 5001:80 --network backend bretfisher/examplevotingapp_result
