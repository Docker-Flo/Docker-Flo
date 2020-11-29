#!/bin/bash

# Move to the container location
cd /home/container

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

# Tell me what the Java version is....
echo "(Hello.... you are running this java version)"
java -version
sleep 2

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
