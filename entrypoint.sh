#!/bin/bash

#Move to the container location
cd /home/container

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

#Going to create an Alias for the NFS share given to us by the Flo System! + Remove the permissions Errors
    ln -s /mnt /home/container/maps 2> /dev/null
    
  if [ -e /home/container/start.sh ]
    then
        echo "Start File Found!"
        else
          echo "WARNING START FILE DOES NOT EXIST = REBUILDING"
          sleep 2
          sh /home/container/maps/reroute.sh
  fi
    
#Run start.sh File!
    sh start.sh
      
# Run the Server 
    ${MODIFIED_STARTUP}

  if [ $? -ne 0 ]; then
      echo "FLO_SCREAM"
      echo "Causes for this could include:"
      echo "      - No Jar file"
      echo "      - Container unable to be built"
      echo "      - Permissions are not in order"
      echo "      - Docker has encountered an internal issue"
      echo "      - The server is crashing too often"
      echo "Please double check log files for more information!"
      exit 1
    fi

#Tell the User Flo has detected the Container Stopped
  echo "Flo Has noticed the container stopped, Hopefully you know this. GoodBye!"
