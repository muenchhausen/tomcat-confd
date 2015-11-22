vagrant plugin install vagrant-docker-compose


 /usr/local/bin/confd -onetime -backend etcd -node docker_etcdservice_1:4001

 ->
 2015-11-18T20:44:42Z 3056ecaabd43 /usr/local/bin/confd[46]: ERROR 501: All the given peers are not reachable (failed to
propose on members [http://localhost:2379 http://localhost:4001] twice [last error: Get http://localhost:4001/v2/keys/my
app/database/url?quorum=false&recursive=true&sorted=true: dial tcp 127.0.0.1:4001: connection refused]) [0]

-> docker container etcd: /bin/run.sh