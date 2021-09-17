#!/bin/sh
export path=/linux/mirattery
export date=`date +%Y%m%d%H%M%S`
export password=weineng0528@@
export sit_path=/appset/mirattery/manager
cd $PROJ_PATH/order
#mvn clean install
mvn install -Dmaven.test.skip=true -Denv=test -U
cd $PROJ_PATH
for ip in `cat $path/ip_list_sit`
do
rsync -a $PROJ_PATH/order/target/mirattery-manager.jar root@$ip:/home/mirattery-manager-test.jar
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
ps -ef|grep manager|grep mirattery|grep -v grep|awk '{print $2}'|xargs kill -9
mv $sit_path/mirattery-manager-test.jar $sit_path/$date.tar
mv /home/mirattery-manager-test.jar $sit_path
nohup java -jar /appset/mirattery/manager/mirattery-manager-test.jar --spring.profiles.active=test >/dev/null  2>&1 &
exit
remotessh
done
rm -rf $PROJ_PATH
