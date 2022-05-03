echo Starting manager
multipass start manager 
echo Starting worker1
multipass start worker1 
echo Starting worker2
multipass start worker2 

echo Verifying nodes started
multipass node ls