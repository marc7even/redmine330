Vagrant.configure("2") do |config|
  config.vm.box = "xenial64"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network :forwarded_port, guest: 80, host: 8888
end
