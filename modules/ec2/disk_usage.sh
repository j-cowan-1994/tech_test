#!/bin/bash

LOG=/var/log/freespace
DISK_SPACE=$(df -h / | awk '{print $4}'| grep -v "Avail")
DATE=$(date +"%Y-%m-%d %H:%M:%S")

function log()
{
if [[ -f ${LOG} ]]; then
 echo "Log file exists"
else
 echo "Log file does not exist"
 touch ${LOG}
fi
}

function free_space()
{
if [[ ! -z ${DISK_SPACE} ]]; then
 echo "Adding disk space usage to log"
 echo "$DATE  $DISK_SPACE" >> $LOG
else
 echo "Error obtaining disk space information."
 exit 1;
fi
}

log
free_space