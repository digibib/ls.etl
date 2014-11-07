Vagrant.configure("2") do |config|
  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.synced_folder "test", "/home/vagrant/vm-test"
  config.vm.synced_folder "data", "/data"

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "ls-etl"

  config.vm.provision :shell, inline: <<SCRIPT
  apt-get update
  apt-get install -y python-pip
  pip install docker-py
  apt-get -y install chromium-browser
  apt-get -y install curl
  apt-get -y install cpanminus
  apt-get -y install libmysqlclient-dev
  locale-gen nb_NO.UTF-8
  cpanm Catmandu
  cpanm HTTP::Request
  cpanm LWP::UserAgent
  cpanm Catmandu::Store::DBI
  cpanm DBD::mysql
SCRIPT

  config.vm.provision :docker do |d|
    d.version = "latest"
  end

end