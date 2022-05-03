echo Stopping manager
multipass stop manager 
echo Stopping worker1
multipass stop worker1 
echo Stopping worker2
multipass stop worker2 

echo Verifying nodes stopped
multipass node ls