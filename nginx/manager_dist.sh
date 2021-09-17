#!/bin/sh
export path=/linux/nginx
export password=swcf2fY@
for ip in `cat $path/ip_list`
do
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
cd /appset/nginx/html/mirattery_manager
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
  spawn scp -r $PROJ_PATH/order/dist root@$ip:/appset/nginx/html/mirattery_manager
  expect {
    \"*password*\" {set timeout 300; send \"swcf2fY@\r\";}
  }
expect eof"
#rm -rf $PROJ_PATH
done
rm -rf $PROJ_PATH
