#!/usr/bin/env bash

ansible_executable=ansible-playbook

if ! [ -x "$(command -v $ansible_executable)" ]; then
  read -p "[+] $ansible_executable was not found, install? [y/n]: " install_ansible
  if [[ "$install_ansible" == [yY] || "$install_ansible" == [yY][eE][sS] ]]; then
    if [[ $OSTYPE == 'darwin'* ]]; then
      echo "[+] Installing ansible with homebrew"
      brew install ansible
    elif [ -x "$(command -v apt)" ]; then
      apt install -y ansible
    else
      echo "[-] Not installing Ansible. No supported package manager was found."
      exit 1
    fi
  else
    echo "[-] ansible-playbook will not be installed, exiting."
    exit 2;
  fi
else
  echo "[+] ansible-playbook found, proceeding with install."
fi

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml
