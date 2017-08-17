#!/bin/bash
echo "╭━━━┳╮        ╭╮  ╭╮  ╭╮"
echo "┃╭━━┫┃        ┃╰╮╭╯┃ ╭╯┃"
echo "┃╰━━┫┃╭━━╮    ╰╮┃┃╭╯ ╰╮┃"
echo "┃╭━━┫┃┃╭╮┃╭━━╮ ┃╰╯┃   ┃┃"
echo "┃┃  ┃╰┫╰╯┃╰━━╯ ╰╮╭╯╭╮╭╯╰╮"
echo "╰╯  ╰━┻━━╯      ╰╯ ╰╯╰━━╯"
echo "Created By Fonix Hardcastle"
sleep 4

cd /home/container

# Output Current Java Version
java -version

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}

if [ $? -ne 0 ]; then
    echo "FONIX_CONTAINER_ERROR: There was an error while attempting to run the start command."
    exit 1
fi
