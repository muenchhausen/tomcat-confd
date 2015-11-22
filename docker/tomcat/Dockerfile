FROM tomcat

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -O /usr/local/bin/confd && chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d && mkdir -p /etc/confd/templates

ADD confd/templates/myconfig.conf.tmpl /etc/confd/templates/myconfig.conf.tmpl
ADD confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml

#etcdctl set /myapp/database/url db.example.com
#etcdctl set /myapp/database/user rob
#confd -onetime -backend etcd -node 127.0.0.1:4001
#/usr/local/tomcat/{conf,bin}


#CMD ["catalina.sh", "run"]
CMD ["/usr/local/bin/confd", "-onetime", "-backend", "etcd", "-node", "docker_etcdservice_1:4001"]

EXPOSE 8080