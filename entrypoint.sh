#!/bin/bash

echo "╭━━━┳╮        ╭╮  ╭╮  ╭╮"
echo "┃╭━━┫┃        ┃╰╮╭╯┃ ╭╯┃"
echo "┃╰━━┫┃╭━━╮    ╰╮┃┃╭╯ ╰╮┃"
echo "┃╭━━┫┃┃╭╮┃╭━━╮ ┃╰╯┃   ┃┃"
echo "┃┃  ┃╰┫╰╯┃╰━━╯ ╰╮╭╯╭╮╭╯╰╮"
echo "╰╯  ╰━┻━━╯      ╰╯ ╰╯╰━━╯"
echo "Created By Fonix Hardcastle"
echo "  https://fonix.online"
  sleep 4

cd /home/container

# Replace Startup Variables
  MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
  echo ":/home/container$ ${MODIFIED_STARTUP}"

#Run the needed setup prefs first!
  echo "I am going to Connect to the Flo NFS system and check we have the files i need!"
  echo ""
  echo ""
  sleep 3
  sh start.sh

#Going to create an Alias for the NFS share given to us by the Flo System!
  echo "Setting up the Flo Backend Alias's to make sure eveyrthing runs nice and smooth!"
  echo ""
  echo ""
  ln -s /mnt/maps /home/container/maps
  sleep 1
  echo "Hopefully you didnt see any errors from that!"

# Run the Server
  ${MODIFIED_STARTUP}

  if [ $? -ne 0 ]; then
      echo "FONIX_CONTAINER_ERROR: There was an error while attempting to run the start command. Consult the All Mighty Fonix! Something went badly wrong!"
      exit 1
    fi

#Tell the User Flo has detected the Container Stopped
  echo "Flo Has noticed the container has stopped, Hopefully you know this."
