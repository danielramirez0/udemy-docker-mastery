echo Verifying manager
multipass exec manager -- docker -v && docker-compose -v
echo Verifying worker1
multipass exec worker1 -- docker -v && docker-compose -v
echo Verifying worker2
multipass exec worker2 -- docker -v && docker-compose -v

echo Verifying node status
multipass exec manager -- docker node list