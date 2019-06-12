#!/bin/bash

function log_correct () {
DATE=`date "+%Y-%m-%d %H:%M:%S"` 
USER=$(whoami) 
echo "${DATE} ${USER} execute $0 [INFO] $@" >>$0.log 
}

function log_error ()
{
    DATE=`date "+%Y-%m-%d %H:%M:%S"`
    USER=$(whoami)
    echo "${DATE} ${USER} execute $0 [error] $@" >>$0.log
}

function fn_log ()
{
    if [ $? -eq 0 ]
    then
        log_correct "$@ sucessed!"
        #echo -e "\033[41;37m $@ sucessed. \033[0m"
    else
        log_error "$@ failed!"
        #echo -e "\033[32m $@ failed. \033[0m"
        exit
    fi
}
