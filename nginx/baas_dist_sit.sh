#!/bin/sh
export path=/linux/nginx
export password=weineng0528@@
for ip in `cat $path/ip_list_sit`
do
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
cd /appset/nginx/html/baas
rm -rf dist
exit
remotessh
#git
#cd /linux/nginx
#git clone -b test https://han.pan%40mirattery.com:2hblsqT%@e.coding.net/mirattery/mirattery-data/mirattery-manager-vue.git
cd $PROJ_PATH/order
npm install 
npm run build:prod
expect -c "
  spawn scp -r $PROJ_PATH/order/dist root@$ip:/appset/nginx/html/baas
  expect {
    \"*password*\" {set timeout 300; send \"$password\r\";}
  }
expect eof"
rm -rf $PROJ_PATH
done
