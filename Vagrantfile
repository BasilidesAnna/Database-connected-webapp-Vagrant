Vagrant.configure("2") do |config|
  config.vm.box = "codecool/ubuntu-18.04-base"

  config.vm.define "db" do |db|
    db.vm.hostname = 'db'
    db.vm.network :private_network, ip: "192.168.56.102"
    db.vm.provision "file", source: "chinook_data.sql", destination: "/tmp/chinook_data.sql"
    db.vm.provision "shell", path: "db.sh"
  end

  config.vm.define "web" do |web|
    web.vm.hostname = 'web'
    web.vm.network "forwarded_port", guest: 8080, host: 8080
    web.vm.provision "file", source: "web.war", destination: "/tmp/web.war"
    web.vm.provision "shell", path: "web.sh"
  end
end
