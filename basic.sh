#!/bin/bash

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

setup_dns() {
    sudo cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak
    sudo sh -c 'echo "DNS=8.8.8.8 114.114.114.114" >> /etc/systemd/resolved.conf'
    sudo systemctl restart systemd-resolved
}

reset_dns() {
    sudo cp /etc/systemd/resolved.conf.bak /etc/systemd/resolved.conf
    sudo systemctl restart systemd-resolved
}

setup_git() {
    git config --global user.email "zhaoruiexplorer@icloud.com"
    git config --global user.name "zhaorui"
}

setup_smb() {
    echo -n "share path [~/Public]: "
    read SHARED_PATH
    eval "SHARED_PATH=${SHARED_PATH}"
    SHARED_PATH=${SHARED_PATH:-~/Public}
    SHARED_NAME=$(basename ${SHARED_PATH})

    mkdir -p ${SHARED_PATH}
    sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
    sudo bash -c 'cat >> /etc/samba/smb.conf' << EOF

[${SHARED_NAME}]
    comment = Samba Shared Folder
    path = ${SHARED_PATH}
    read only = no
    browsable = yes

EOF
    sudo systemctl restart smbd
}

