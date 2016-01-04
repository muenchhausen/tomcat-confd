## what is it?
This is a sample running multiple [Tomcats](http://tomcat.apache.org/) and a [Apache WebServer](http://httpd.apache.org/) for load balancing using a central Configuration Service [etcd](https://github.com/coreos/etcd).

The main subject under sample is [confd](https://github.com/kelseyhightower/confd). It is tiny  useful tool to move local configuration to a central configuration repositories a la [etcd](https://github.com/coreos/etcd), [consul](http://consul.io), [dynamodb](http://aws.amazon.com/dynamodb/), [redis](http://redis.io), [zookeeper](https://zookeeper.apache.org).   

## what does the demo exactly?
Apache Tomcat uses config files e.g. tomcat-users.xml to define access rights to the manager webapp. Here the admin user shall be configured centrally, so we can define it within etcd.

## running it
This sample uses Vagrant and VMware or VirtualBox - but this is optional. You can run the containers in your prefered Docker environment. 

```
vagrant plugin list
vagrant plugin install vagrant-docker-compose
```
Clone this repo, run 
```
vagrant up
```
Find out the IP of your VM. Open your Browser, go to Tomcat Manager e.g.
http://192.168.xx.xx:8081/manager/
login with Username admin and Password admin

## some code snippets
manual build within the VM :)
```
docker build -t docker_tomcatservice .

docker-compose up


curl -L http://192.168.99.100:2379/v2/keys/tomcat/user -XPUT -d value='admin' && \
curl -L http://192.168.99.100:2379/v2/keys/tomcat/password -XPUT -d value='admin' && \
curl -L http://192.168.99.100:2379/v2/keys/tomcat/proxyName -XPUT -d value='myProxyName' 

/usr/local/tomcat/webapps/manager/whoIsIt.html
```
