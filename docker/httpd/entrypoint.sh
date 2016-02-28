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

echo "[httpd-confd] booting container. ETCD: $ETCD_NODE"

export HOSTNAME=`hostname`

until confd -onetime -node "$ETCD_NODE"; do
  echo "[tomcat-confd] waiting for confd to refresh tomcat config files"
  sleep 3
done

echo "[httpd-confd] Initial config created. Starting confd"

confd -node "$ETCD_NODE"
