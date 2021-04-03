#!/bin/bash

FILE=/srv/emercoind/emercoin.conf
echo -n -e "Set a password for the RPC JSON connection to the wallet \n or press [ENTER] (will keep the current one) ":
read -s -t 15 new_pass
echo
old_pass=$(cat $FILE | grep "rpcpassword" | cut -d'=' -f2)

if [ "$new_pass" == "" ]; then
  exit 1
fi
if [ "$new_pass" == "$old_pass" ]; then
  echo "The entered password matches the current one"
  exit 0
 else
   echo -e "\e[31mPassword changed!\e[0m"
   path=rpcpassword=$new_pass
   sed -i "s#.*rpcpassword.*#$path#g" $FILE
   ./emercoin-cli restart
   exit 0
fi

