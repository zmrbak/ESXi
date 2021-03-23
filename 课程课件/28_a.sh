#!/bin/sh

VM_LIST=$(vim-cmd  vmsvc/getallvms | grep -v Vmid | awk '{print $2,$1}')

i=0
for VM in $VM_LIST
do
  i=$(($i+1))
  if [ $(($i%2)) == 0 ]
  then
    STATE=$(vim-cmd  vmsvc/power.getstate $VM | tail -1 | awk '{print $2}')
    #if [ $STATE == on ]
    #then
    #  vim-cmd vmsvc/power.shutdown $VM
    #  printf "\n" $STATE
    #fi
    
    if [ $STATE == off ]
    then
      vim-cmd vmsvc/power.on $VM
      printf "\n" $STATE
    fi
    
  else
    printf "%-15s" $VM
  fi
done