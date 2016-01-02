#!/bin/bash

# source: https://github.com/yaronr/dockerfile/blob/master/haproxy-confd

if [ -z "$ETCD_NODE" ]
then
  echo "Missing ETCD_NODE env var"
  exit -1
fi

# the pipeline’s return status is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands exit successfully
# The shell waits for all commands in the pipeline to terminate before returning a value. 
set -eo pipefail

#confd will start tomcat, since conf will be different than existing (which is null)

echo "[tomcat-confd] booting container. ETCD: $ETCD_NODE"

function config_fail()
{
	echo "Failed to start due to config error"
	exit -1
}

# Loop until confd has updated the tomcat config
n=1
until confd -onetime -node "$ETCD_NODE"; do
  #if [ "$n" -eq "10" ];  then config_fail; fi
  echo "[tomcat-confd] waiting for confd to refresh tomcat config files"
  n=$((n+1))
  sleep 3
  #sleep $n
done

echo "[tomcat-confd] Initial config created. Starting confd"

confd -node "$ETCD_NODE"
