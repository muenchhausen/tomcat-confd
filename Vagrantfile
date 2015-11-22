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
  
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker/docker-compose.yml", run: "always"

  config.vm.provision "shell", name: "configure etcd", inline: "curl -L http://127.0.0.1:2379/v2/keys/myapp/database/url -XPUT -d value='db.example.com' && curl -L http://127.0.0.1:2379/v2/keys/myapp/database/user -XPUT -d value='rob'"

end
