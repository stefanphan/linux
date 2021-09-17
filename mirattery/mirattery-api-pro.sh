#!/bin/sh
export path=/linux/mirattery
export date=`date +%Y%m%d%H%M%S`
export password=weineng0528@@
export sit_path=/appset/mirattery/api
cd $PROJ_PATH/order
#mvn clean install
mvn install -Dmaven.test.skip=true -Denv=prod -U
cd $PROJ_PATH
for ip in `cat $path/ip_list_api_pro`
do
rsync -a $PROJ_PATH/order/target/*.jar root@$ip:/home/mirattery-api-prod.jar
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
ps -ef|grep mirattery|grep api|grep -v grep|awk '{print $2}'|xargs kill -9
mv $sit_path/mirattery-api-prod.jar $sit_path/$date.tar
mv /home/mirattery-api-prod.jar $sit_path
nohup java -jar /appset/mirattery/api/mirattery-api-prod.jar --spring.profiles.active=prod >/dev/null 2>&1 &
exit
remotessh
done
rm -rf $PROJ_PATH

