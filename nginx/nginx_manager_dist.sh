#!/bin/bash
expect -c "
  spawn scp -r $PROJ_PATH/nginx/manager_dist/dist root@$ip_1:/appset/nginx/html/mirattery_manager
  expect {
    \"*password*\" {set timeout 300; send \"swcf2fY@\r\";}
  }
expect eof"
expect -c "
  spawn scp -r $PROJ_PATH/nginx/manager_dist/dist root@$ip_2:/appset/nginx/html/mirattery_manager
  expect {
    \"*password*\" {set timeout 300; send \"swcf2fY@\r\";}
  }
expect eof"
