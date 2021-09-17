#!/bin/sh
export path=/linux/baas
export date=`date +%Y%m%d%H%M%S`
export password=weineng0528@@
export pro_path=/appset/baas
cd $PROJ_PATH/order
mvn install -Dmaven.test.skip=true -Denv=prod -U
for ip in `cat $path/ip_list_mgm`
do
rsync -a $PROJ_PATH/order/target/baas-manager.jar root@$ip:/home/baas-manager.jar
sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip -tt > /dev/null 2>&1 << remotessh
ps -ef|grep baas|grep -v grep|awk '{print $2}'|xargs kill -9
mv $pro_path/baas-manager.jar $pro_path/$date.tar
mv /home/baas-manager.jar $pro_path
nohup java -jar /appset/baas/baas-manager.jar --spring.profiles.active=prod >/dev/null  2>&1 &
exit
remotessh
done
rm -rf $PROJ_PATH
