# tomcat-conf
This is a starting point for running and administrating multiple [Apache Tomcat](http://tomcat.apache.org/) using a central Configuration Repository - here [etcd](https://github.com/coreos/etcd).

The main subject under test&sample is [confd](https://github.com/kelseyhightower/confd). It is a tiny  useful tool to move distributed local configuration files to a central configuration repositories. Various other configuration repositories like [etcd](https://github.com/coreos/etcd), [redis](http://redis.io), [consul](http://consul.io), [dynamodb](http://aws.amazon.com/dynamodb/), [zookeeper](https://zookeeper.apache.org) could be used instead of etcd if required.   

Soon a [Apache WebServer](http://httpd.apache.org/) for load balancing will be added :)

## what is it doing?
Apache Tomcat uses config files e.g. ```tomcat-users.xml``` to define access rights to the manager webapp or ```server.xml``` to define connectors. Here the admin credentials shall be configured centrally, so we can change them within etcd.

The full list of confd responsible configurations - all of them stored in etcd under the prefix 'tomcat':
- ```Xmx```: maximum heap size
- ```Xms```: initial heap size
- ```username```: manager webapp username
- ```password```: manager webapp password
- ```jvmRoute```: here Tomcat hostname (as defined in docker-compose.yml)


## run it
This sample uses Vagrant and VMware or VirtualBox. Vagrant is optional. You can run the two Tomcat containers and etcd in your prefered Docker environment. A Docker-Compose file exists for that. 

```
vagrant plugin list
vagrant plugin install vagrant-docker-compose
```
Clone this repo, run it
```
git clone https://github.com/muenchhausen/tomcat-confd.git
cd tomcat-confd
vagrant up
```

Find out the IP of your VM - e.g. login into the VM (sometimes credentials ```vagrant vagrant``` are required)
```
vagrant ssh
ifconfig
```

Open your Browser, go to Tomcat Manager 
http://192.168.xx.xx:8081/manager/
login with credentials ```admin``` and ```admin```

try also second Tomcat Manager 
http://192.168.xx.xx:8082/manager/
login with same credentials as above

## some interesting code snippets

Besides the automatic ```vagrant up``` way, you can play around with manual steps. Here some ideas...

manually rebuild everything within the VM
```
sudo su -
cd /vagrant/docker
docker-compose stop && docker-compose rm -f && docker-compose build
docker-compose up --force-recreate
```

open another bash - fill in the required etcd keys - after doing this tomcat should start

```
curl -L http://localhost:2379/v2/keys/tomcat/Xmx -XPUT -d value='1024M' && \
curl -L http://localhost:2379/v2/keys/tomcat/Xms -XPUT -d value='512M' && \
curl -L http://localhost:2379/v2/keys/tomcat/user -XPUT -d value='admin' && \
curl -L http://localhost:2379/v2/keys/tomcat/password -XPUT -d value='admin'
```

debug confd - e.g. test if templates are ok
```
/usr/local/bin/confd -onetime -backend etcd -node docker_etcdservice_1:4001
```
