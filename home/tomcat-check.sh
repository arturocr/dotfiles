#!/bin/bash
until [ "`curl --silent --connect-timeout 1 -I http://localhost:8080 | grep 'Coyote'`" != "" ];
do
  echo --- Tomcat is not ready waiting 10 seconds more
  sleep 10
done
echo "Tomcat is ready!"