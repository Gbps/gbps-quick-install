#!/bin/bash
echo "=============== Gbps Startup Script ==============="
if [ "$EUID" -ne 0 ]
then 
    echo "Please run as root!"
    echo "sudo $0" 
    exit
fi

function execute_cmd
{
    echo "> $@"
    eval $@
}

function execute_yn
{
    read -p " [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        execute_cmd $@
    fi
}

function update_apt_packages
{
    echo "Updating apt repositiories"
    execute_cmd apt-get update

    echo "Updating packages"
    execute_cmd apt-get upgrade -y

    echo "Insalling Git (Required)"
    execute_cmd apt-get install -y git
}

function fetch_script_prerequisites
{
	echo "Fetching repo"
	execute_cmd "git -C ~/.gbps-quick/ pull || git clone https://github.com/Gbps/gbps-quick-install ~/.gbps-quick/"
}

function update_hostname
{
    printf "New hostname?: "
    read hostname
    printf "Are you sure you want to change the hostname to: %s? [y/n]" $hostname
    read -n 1 -r
    echo 
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        execute_cmd hostname $hostname
        execute_cmd "echo $hostname > /etc/hostname"
        execute_cmd "echo 127.0.0.1 $hostname >> /etc/hosts"
        echo "Done."
    else
        update_hostname
    fi
}

function install_zsh
{
    echo "Grabbing zsh"
    execute_cmd sudo apt-get install zsh

    echo "Installing oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

    echo "Done."
}

function install_vim
{
	echo "Installing vim"
	execute_cmd apt-get install -y vim
	
	echo "Copying vimrc"
	execute_cmd cp ~/.gbps-quick/vim/.vimrc ~/.vimrc

    echo "Done."
}

function install_ssh_keys
{
    echo "Creating gbps user"
    execute_cmd adduser gbps

    echo "Adding gbps to sudo"
    execute_cmd adduser gbps sudo

    echo "Copying ssh keys"
    execute_cmd mkdir /home/gbps/.ssh
    execute_cmd cp ~/.gbps-quick/ssh/authorized_keys /home/gbps/.ssh/authorized_keys

    su gbps
    printf "Install zsh?"
    execute_yn install_zsh
    exit

    echo "Done."
}
function main
{
    update_apt_packages

    fetch_script_prerequisites

    printf "Update hostname?"
    execute_yn update_hostname

    printf "Create gbps user and install ssh keys?"
    execute_yn install_ssh_keys
    
    printf "Install vim?"
    execute_yn install_vim

    echo "Script done."
}

main
