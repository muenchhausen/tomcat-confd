FROM debian:jessie
MAINTAINER derk@muenchhausen.de

RUN apt-get update \
	&& apt-get install -y \
		apache2 \
		libapache2-mod-proxy-html


ADD proxy_ajp.conf /etc/apache2/mods-available/
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




	
#ADD httpd-foreground /usr/local/bin/

# RUN echo "Include conf/extra/proxy.conf" | tee -a /usr/local/apache2/conf/httpd.conf

EXPOSE 80 443 
VOLUME ["/var/log"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND", "-e", "debug"]
