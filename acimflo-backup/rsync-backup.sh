#!/bin/bash

#Détourne le signal SIGINT
trap 'echo Control-C exit ...; exit 1' INT

SECOND_TO_WAIT_BEFORE_START_PROCESS=300
sleep $SECOND_TO_WAIT_BEFORE_START_PROCESS

##############################
#  CONFIGURATION RSYNC/SSH
##############################
#Répertoire où sont stockés les fichiers du backup
repertoireRsyncBackup="/mnt/donnees/Replication/"
# Clé SSH pour s'authentifier sur le serveur distant
sshkey="/home/jerep6/.ssh/agence_pwdless"

# Adresse du serveur en variable d'environnement
serveur=$SERVEUR_TO_BACKUP

#Utilisateur ssh du serveur
#utilisateur="system@"
utilisateur=""

#Option de rsync
#RSYNC_OPTS_GENERALES="-av --delete --exclude-from $(dirname $0)/exclude.rsync"
RSYNC_OPTS_GENERALES="-av --delete --compress"
RSYNC_OPTS_SSH="-p 443 -i $sshkey -o StrictHostKeyChecking=no"

COMMAND_TO_VERIFIE_ENCRYPTED_PARTITION="ssh $RSYNC_OPTS_SSH -t $utilisateur$serveur 'mount | grep /data_crypt'"

##############################
#   CONFIGURATION DOSSIERS
##############################
#synchroSource = Tableau contenant le chemin des dossiers de l'agence à synchroniser
#synchroDest = Tableau contenant le chemin des dossiers (sur le serveur)
synchroSource[1]="/data/Agence/"
synchroDest[1]=$repertoireRsyncBackup"Agence/"


#Vérifie que la partition chiffrée est montée avant de le synchroniser les dossiers
RES=`eval $COMMAND_TO_VERIFIE_ENCRYPTED_PARTITION`

if [ -n "$RES" ]; then
    synchroSource[2]="/data_crypt/Florence/"
    synchroDest[2]=$repertoireRsyncBackup"Florence/"
else
  echo "$COMMAND_TO_VERIFIE_ENCRYPTED_PARTITION n'a retourné aucun point de montage"
fi

################# TRAITEMENT #################
#Parcours du tableau synchroSource pour uploader les dossiers
for index in "${!synchroSource[@]}"; do
    echo ${synchroSource[$index]} "==>" ${synchroDest[$index]};
    echo "rsync $RSYNC_OPTS_GENERALES -e \"ssh $RSYNC_OPTS_SSH\" $utilisateur$serveur:${synchroSource[$index]} ${synchroDest[$index]}"
    rsync $RSYNC_OPTS_GENERALES -e "ssh $RSYNC_OPTS_SSH" $utilisateur$serveur:${synchroSource[$index]} ${synchroDest[$index]}
done