#!/bin/bash
echo "=============== Gbps Startup Script ==============="
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

}

function fetch_script_prerequisites
{
    echo "Insalling Git (Required)"
    execute_cmd apt-get install -y git

    echo "Fetching repo"
    execute_cmd "git -C ~/.gbps-quick/ pull || git clone https://github.com/Gbps/gbps-quick-install ~/.gbps-quick/"

    echo "Fixing permissions"
    REALUSER=$(stat -c '%U' ~)
    execute_cmd chown -R $REALUSER:$REALUSER ~/.gbps-quick
}

function install_git_configs
{
    echo "Installing Git Configs"
    
    execute_cmd git config --global user.email "gbps@ctf.re"
    execute_cmd git config --global user.name "Michael"
    execute_cmd git config --global push.default simple
    execute_cmd git config --global core.editor "vim"    

    echo "Done."
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
    execute_cmd sudo apt-get install zsh -y

    echo "Installing oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

    echo "Done."
}

function install_zsh_configs
{
    if [ ! -d ~/.oh-my-zsh ]; then
        install_zsh
    fi

    echo "Installing zsh config"

    execute_cmd mv ~/.zshrc ~/.zshrc.bak

    execute_cmd ln -s ~/.gbps-quick/zsh/.zshrc ~/.zshrc
    
    echo "Done."
}
function install_vim
{
    echo "Installing vim"
    execute_cmd apt-get install -y vim
    
    echo "Copying vimrc"
    execute_cmd mv ~/.vimrc ~/.vimrc.bak
    execute_cmd ln -s ~/.gbps-quick/vim/.vimrc ~/.vimrc

    echo "Done."
}

function create_user
{

    echo "Creating gbps user"
    execute_cmd adduser gbps

    echo "Adding gbps to sudo"
    execute_cmd adduser gbps sudo
}

function install_ssh_keys
{
    echo "Copying ssh keys"
    execute_cmd mkdir /home/gbps/.ssh
    execute_cmd cp ~/.gbps-quick/ssh/authorized_keys /home/gbps/.ssh/authorized_keys

    echo "Done."
}
function main
{
    printf "Update apt packages?"
    execute_yn update_apt_packages

    printf "Fetch script pre-requisites?"
    execute_yn fetch_script_prerequisites

    printf "Install zsh?"
    execute_yn install_zsh_configs

    printf "Update hostname?"
    execute_yn update_hostname

    printf "Create gbps user?"
    execute_yn create_user

    printf "Install ssh keys?"
    execute_yn install_ssh_keys
    
    printf "Install vim?"
    execute_yn install_vim

    printf "Install git configs?"
    execute_yn install_git_configs

    echo "Script done."
}

main
