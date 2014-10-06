# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = true

  config.ssh.forward_agent = true
  config.vm.network "private_network", ip: "192.168.33.30"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "680"]
  end

  # Vagrant Cachier - more info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :composer
    config.cache.enable :generic, { "wget" => { cache_dir: "/var/cache/wget" } }
    config.cache.synced_folder_opts = { type: :nfs, mount_options: ['rw', 'vers=3', 'tcp', 'nolock'] }
  end

  # provision with masterless salt
  config.vm.synced_folder "salt/srv_salt", "/srv/salt/"
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.verbose = true
    salt.bootstrap_script = "salt/bootstrap-salt.sh"
  end

end
