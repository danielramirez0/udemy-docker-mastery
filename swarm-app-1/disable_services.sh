#!/bin/bash

echo "Removing networks"
multipass exec manager -- docker network rm backend frontend

echo "Removing services"
multipass exec manager -- docker service rm vote redis worker postgres result
