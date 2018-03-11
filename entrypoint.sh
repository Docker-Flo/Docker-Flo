#!/bin/bash

# Move to the container location
cd /home/container

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

# Going to create an Alias for the NFS share given to us by the Flo System! + Remove the permissions Errors
  mkdir -p /home/container/maps
    ln -s /mnt/ /home/container/maps
    
# Check for the start script to fix start issues    
  if [ ! -f /home/container/start.sh ]
    then
       sh /mnt/reroute.sh
  fi
    
# Run pre-made flo retrive script File!
    sh start.sh
      
# Run the Server from Pterodactyl passthrough variables
    ${MODIFIED_STARTUP}

# Server Start failure message
  if [ $? -ne 0 ]; then
      echo "FLO_SCREAM"
      echo "Causes for this could include:"
      echo "      - No Jar file"
      echo "      - Container unable to be built"
      echo "      - Permissions are not in order"
      echo "      - Docker has encountered an internal issue"
      echo "      - The server is crashing too often"
      exit 1
    fi

#Tell the User Flo has detected the Container Stopped
  echo "- = CONTAINER STOPPED = -"
