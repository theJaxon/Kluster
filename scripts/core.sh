#!/bin/bash
echo "TASK [1] Install core utilities"
apt-get install -y ansible bash-completion etcd-client sshpass vim apt-transport-https

echo "TASK [2] Run Kluster role"
ansible-playbook -b /vagrant/Kluster.yml