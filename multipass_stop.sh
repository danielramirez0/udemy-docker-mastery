echo Stopping all nodes
multipass stop manager 
multipass stop worker1 
multipass stop worker2 

echo Verifying nodes stopped
multipass ls
