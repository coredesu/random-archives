#! /bin/sh
cat servers | while read line 
do
   echo  "[\033[1;33mWAIT\033[0m] Starting SFTP connection..."
   echo "You need to close the thunar process to continue."
   thunar $line > /dev/null
    echo  "[\033[0;32mOK\033[0m] Starting SFTP connection..."
done
