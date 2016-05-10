# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.network "forwarded_port", guest: 22, host: 2200, id: "ssh"
  config.vm.network "private_network", ip: "10.10.10.10"

  config.vm.synced_folder ".", "/vagrant", disabled:true
  config.vm.synced_folder ".", "/app/setup"
  config.vm.synced_folder "../source", "/app/source"

  # Using existed private key and do not generate a key
  config.ssh.insert_key = false
  config.ssh.private_key_path = ["./keys/id_rsa", "~/.vagrant.d/insecure_private_key"]

  # Auto update vbguest if plugin "vagrant-vbguest" is installed
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = true
  end

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.cpus = 1
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Copy public key to VM
  config.vm.provision "file", source: "./keys/id_rsa.pub", destination: "~/.ssh/authorized_keys"

  config.vm.provision "shell", inline: <<-EOC
echo ">> Update and install common packages"
sudo yum -y -q update
sudo yum -y -q install git curl

echo ">> Prevent access with plaintext password"
sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
sudo service sshd restart

echo ">> Load customize bashrc"
if [ -f /app/setup/.bashrc ]
then
  echo "source /app/setup/.bashrc" >> /home/vagrant/.bashrc;
fi

  EOC

  config.vm.provision "shell", path: "./scripts/install.sh"
  config.vm.provision "shell", path: "./scripts/build.sh"

end
