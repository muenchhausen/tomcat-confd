Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 3000
    v.cpus = 2
  end

  config.vm.provider "vmware_workstation" do |v|
  	v.name = "tomcat-confd"
  	v.gui = true
  	config.ssh.pty= true
  	v.memory = 3000
  	v.cpus = 2
  end

  # not sure if this is really required:
  #config.vm.provision "shell", inline:
  #  "ps aux | grep 'sshd:' | awk '{print $2}' | xargs kill"

  config.vm.box = "williamyeh/ubuntu-trusty64-docker"
  
  #config.vm.provision "shell", name: "update os", inline: "sudo apt-get update -y -q"
  #config.vm.provision "shell", name: "upgrade docker-engine", inline: "sudo apt-get upgrade -y -q"
  config.vm.provision "shell", name: "docker-compose", inline: "curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose"

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker/docker-compose.yml", run: "always"

  config.vm.provision "shell", name: "configure etcd", inline: "\
    wget --retry-connrefused --waitretry=1 --read-timeout=1 --timeout=1 -t 10 -qO- http://127.0.0.1:2379/v2/keys/ && \
    curl -L http://127.0.0.1:2379/v2/keys/tomcat/user -XPUT -d value='admin' && \
    curl -L http://127.0.0.1:2379/v2/keys/tomcat/password -XPUT -d value='admin' && \
    curl -L http://127.0.0.1:2379/v2/keys/tomcat/proxyName -XPUT -d value='myProxyName' \
  ", run: "always"

end
