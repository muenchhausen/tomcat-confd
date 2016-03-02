FROM debian:jessie
MAINTAINER derk@muenchhausen.de

ENV ETCD_NODE docker_etcdservice_1:4001

RUN apt-get update \
	&& apt-get install -y \
		wget \
		apache2 \
		libapache2-mod-proxy-html

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -O /usr/local/bin/confd && chmod +x /usr/local/bin/confd

ADD entrypoint.sh /entrypoint.sh
ADD confd /etc/confd
ADD proxy_balancer.conf /etc/apache2/mods-available/

RUN ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load
RUN ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf
RUN ln -s /etc/apache2/mods-available/proxy_ajp.load /etc/apache2/mods-enabled/proxy_ajp.load
RUN ln -s /etc/apache2/mods-available/proxy_ajp.conf /etc/apache2/mods-enabled/proxy_ajp.conf
RUN ln -s /etc/apache2/mods-available/slotmem_shm.load /etc/apache2/mods-enabled/slotmem_shm.load
RUN ln -s /etc/apache2/mods-available/proxy_balancer.load /etc/apache2/mods-enabled/proxy_balancer.load
RUN ln -s /etc/apache2/mods-available/proxy_balancer.conf /etc/apache2/mods-enabled/proxy_balancer.conf
RUN ln -s /etc/apache2/mods-available/lbmethod_byrequests.load /etc/apache2/mods-enabled/lbmethod_byrequests.load

RUN sed -i -e "s/Require local/Require all granted/" /etc/apache2/mods-available/status.conf

EXPOSE 80 443 
VOLUME ["/var/log"]

# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND", "-e", "debug"]
CMD ["/entrypoint.sh"]
