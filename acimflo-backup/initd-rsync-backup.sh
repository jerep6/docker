#!/bin/bash
# /etc/init.d/vms
#
### BEGIN INIT INFO
# Provides:                     rsync-backup
# Required-Start:               $local_fs $remote_fs $network
# Should-Start:
# Should-Stop:
# Required-Stop:
# Default-Start:                2 3 4 5
# Default-Stop:                 0 1 6
# X-Interactive:                true
# Short-Description:            Start backup script
# Description:                  Start backup script
### END INIT INFO


#
# main part
#
#PATH=/sbin:/usr/sbin:/usr/bin:/bin

# Add this script to boot
#update-rc.d init.d-rsync-backup defaults


LOG=/var/log/rsync/$(date +\%Y-\%m-\%d).txt
mkdir -p /var/log/rsync

export SERVEUR_TO_BACKUP="tyrosse.jerep6.fr"
BACKUP_SCRIPT_PATH="/home/jerep6/rsync-backup.sh"
SECOND_TO_WAIT_BEFORE_START_PROCESS=300
USER_TO_RUN_SCRIPT=jerep6


case "$1" in
    start)
        echo `date` echo "Starting backup-script and wait $SECOND_TO_WAIT_BEFORE_START_PROCESS before run backup" >> $LOG

        sudo -E -u $USER_TO_RUN_SCRIPT bash -c "(sleep $SECOND_TO_WAIT_BEFORE_START_PROCESS ; $BACKUP_SCRIPT_PATH)"  > $LOG &
        echo "$!" > "/var/run/rsync-backup.pid"
        ;;
    stop)
        PID=$(cat "/var/run/rsync-backup.pid")
        echo `Kill rsync-backup $PID" >> $LOG
        
esac
