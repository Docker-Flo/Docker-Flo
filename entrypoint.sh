#!/bin/bash

# Move to the container location
cd /home/container

# Going to create an Alias for the NFS share given to us by the Fad System! + Remove the permissions Errors
    if [ -d "maps" ]; then
      rm -rf maps
    fi
    mkdir -p /home/container/maps
    ln -s /mnt/maps /home/container/maps

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    
# Check for the start script to fix start issues    
  if [ ! -f /home/container/fad-preflight.sh ]
    then
       wget 10.50.0.126/fad-preflight.sh && sh fad-preflight.sh
    else 
    sh fad-preflight.sh
  fi
    

# Run the Server from Pterodactyl passthrough variables
    ${MODIFIED_STARTUP}

# Server Start failure message
  if [ $? -ne 0 ]; then
      echo "FAD_SCREAM"
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
