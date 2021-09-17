#!/bin/sh
export path=/linux/baas
export date=`date +%Y%m%d%H%M%S`
export password=weineng0528@@
export sit_path=/appset/baas
cd $PROJ_PATH/order
mvn install -Dmaven.test.skip=true -Denv=test -U
for ip in `cat $path/ip_list_sit`
do
#expect -c "
#  spawn scp -r $PROJ_PATH/order/target/mirattery-manager.jar root@$ip:/tmp/mirattery-manager-test.jar
#  expect {
#    \"*password*\" {set timeout 300; send \"$password\r\";}
#  }
#expect eof"
#scp -r $PROJ_PATH/order/target/baas-manager.jar root@$ip:/home/baas-manager.jar
rsync -a $PROJ_PATH/order/target/baas-manager.jar root@$ip:/home/baas-manager.jar
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
ps -ef|grep baas-manager|grep -v grep|awk '{print $2}'|xargs kill -9
mv $sit_path/baas-manager.jar $sit_path/$date.tar
mv /home/baas-manager.jar $sit_path
nohup java -jar /appset/baas/baas-manager.jar --spring.profiles.active=test >/dev/null  2>&1 &
exit
remotessh
done
rm -rf $PROJ_PATH
