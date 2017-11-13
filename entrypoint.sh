#!/bin/bash
cd /home/container

#Talk about debug mode!
echo "DEBUG MODE NON-ACTIVE!"

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ${MODIFIED_STARTUP}"
    
#Run start.sh File!
      sh start.sh

#Going to create an Alias for the NFS share given to us by the Flo System!
    ln -s /mnt /home/container/maps
      
# Run the Server 
    ${MODIFIED_STARTUP}

  if [ $? -ne 0 ]; then
      echo "FONIX_CONTAINER_ERROR"
      echo "Causes for this could include:"
      echo "      - No .jar file"
      echo "      - Container unable to be built"
      echo "      - Permissions are not in order"
      echo "      - Container is un-bailed to be built"
      echo "Please double check log files for more information!"
      sleep 1
      exit 1
    fi

#Tell the User Flo has detected the Container Stopped
  echo "Flo Has noticed the container has stopped, Hopefully you know this. GoodBye!"
  
#Copy over the Gradle information to the NFS share 
   echo "Copying .gradle files to the NFS share"
     mkdir /mnt/.gradle/servers/${SERVER_UUID}
       cp -r /home/container/.gradle/* /mnt/.gradle/servers/${SERVER_UUID}
       echo "Done! {CONTAINER STOPPED}
