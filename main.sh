#!/bin/bash

# create backup 
BACKUP_DIR=/tmp/backup_conf

# Color
GR='\033[0;32m'
YL='\033[1;33m'
PL='\033[0;35m'
NC='\033[0m' 

# Start

#-------------------------------HELP-------------------------#
Help()
{
   # Display Help
   echo -e "Syntax: ${YL}./main.sh${NC} [-d|h]"
   echo "options:"
   echo -e "-d  Config file directory, default: ${PL}/etc/nginx/enable"${NC}
   echo "-h Help!"
   echo
}

# -------------------------------MAIN---------------------------
Main(){
    echo -e "${GR}[+] Creating backup folder ...${NC}"
    sleep 1
    mkdir -p $BACKUP_DIR
    echo -e "${YL}[!] If you want to undo, find the backup files here: ${GR}$BACKUP_DIR${NC}"

    if [ -z "$CONFIG_DIR_ARG" ]
    then
        for entry in "/etc/nginx/enable/*"
        do
            echo -e "[+] Backing up ${GR}$entry${NC}"
            cat $entry > $BACKUP_DIR/${entry##*/}.backup
            sleep 1

            echo -e "[+] Editing ... ${GR}$entry${NC}"
            sed 's/security\.fis\.vn/fis-security\.fpt\.com/g' $entry > $entry
            sleep 1

            echo -e "[+] $entry -> ${GR}Done!${NC}"
        done
    else
        for entry in "$CONFIG_DIR_ARG"/*
        do
            echo -e "[+] Backing up ${GR}$entry${NC}"
            cat $entry > $BACKUP_DIR/${entry##*/}.backup
            sleep 1

            echo -e "[+] Editing ... ${GR}$entry${NC}"
            sed 's/security\.fis\.vn/fis-security\.fpt\.com/g' $entry > $entry
            sleep 1

            echo -e "[+] $entry -> ${GR}Done!${NC}"
        done
    fi    
}

#------------------------------OPTIONS----------------------# 
while getopts d:h option
do
    case "${option}" in
        d) CONFIG_DIR_ARG=${OPTARG}
            Main
            exit;;
         
        h) # display Help
         Help
         exit;;
    esac
done

# by ErikHorus 11/08/2023


