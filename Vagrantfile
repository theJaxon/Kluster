ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-20.04"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  # Kubernetes Worker Nodes
  (1..2).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "192.168.100.1#{i}"
      worker.vm.provider "virtualbox" do |vb|
        vb.name = "worker#{i}"
        vb.memory = 3072
        vb.cpus = 1
      end
    end
  end

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.100.10"
    master.vm.provision "shell", path: "scripts/core.sh"
    master.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.cpus = 2
      vb.memory = "4096"
    end
  end
end
