## what is it?
This is a sample running multiple [Tomcats](http://tomcat.apache.org/) and a [Apache WebServer](http://httpd.apache.org/) for load balancing using a central Configuration Service [etcd](https://github.com/coreos/etcd).

The main subject under test is [confd](https://github.com/kelseyhightower/confd). It is a tiny  useful tool to move distributed local configuration files to a central configuration repositories a la [etcd](https://github.com/coreos/etcd), [redis](http://redis.io), [consul](http://consul.io), [dynamodb](http://aws.amazon.com/dynamodb/), [zookeeper](https://zookeeper.apache.org).   

## what is it doing?
Apache Tomcat uses config files e.g. tomcat-users.xml to define access rights to the manager webapp. Here the admin user shall be configured centrally, so we can define it within etcd.

Supported Tomcat configurations in etcd with the prefix tomcat:
- Xmx: maximum heap size
- Xms: initial heap size
- username: manager webapp username
- password: manager webapp password
- jvmRoute: this is set to hostname defined in docker-compose.yml

## run it
This sample uses Vagrant and VMware or VirtualBox - but this is optional. You can run the containers in your prefered Docker environment. 

```
vagrant plugin list
vagrant plugin install vagrant-docker-compose
```
Clone this repo, run 
```
cd tomcat-confd
vagrant up
```
Find out the IP of your VM. Open your Browser, go to Tomcat Manager e.g.
http://192.168.xx.xx:8081/manager/
login with Username admin and Password admin

## start more tomcat instances
```
vagrant ssh
sudo su -
cd /vagrant/docker

```

## some interesting code snippets

manually build the tomcat Docker image within the VM :)
```
sudo su -
cd /vagrant/docker/tomcat
docker build -t docker_tomcatservice .

cd /vagrant/docker
docker-compose up
```

or manually rebuild everything within the VM
```
sudo su -
cd /vagrant/docker
docker-compose stop && docker-compose rm -f && docker-compose build
docker-compose up --force-recreate -d
```

open a new bash - fill in the required etcd keys

```
curl -L http://localhost:2379/v2/keys/tomcat/Xmx -XPUT -d value='1024M' && \
curl -L http://localhost:2379/v2/keys/tomcat/Xms -XPUT -d value='512M' && \
curl -L http://localhost:2379/v2/keys/tomcat/user -XPUT -d value='admin' && \
curl -L http://localhost:2379/v2/keys/tomcat/password -XPUT -d value='admin'

# by the way: The order matters: this is not working (!)
curl -L http://localhost:2379/v2/keys/tomcat/user -XPUT -d value='admin' && \
curl -L http://localhost:2379/v2/keys/tomcat/password -XPUT -d value='admin' && \
curl -L http://localhost:2379/v2/keys/tomcat/Xmx -XPUT -d value='1024M' && \
curl -L http://localhost:2379/v2/keys/tomcat/Xms -XPUT -d value='512M' 

```

debug confd - e.g. if templates are ok
```
/usr/local/bin/confd -onetime -backend etcd -node docker_etcdservice_1:4001
```

todo:
/usr/local/tomcat/webapps/manager/whoIsIt.html
