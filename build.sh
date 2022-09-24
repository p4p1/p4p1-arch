#!/bin/bash
# build.sh
# Created on: Sat 24 Sep 2022 02:07:07 AM BST
#
#  ____   __  ____  __
# (  _ \ /. |(  _ \/  )
#  )___/(_  _))___/ )(
# (__)    (_)(__)  (__)
#
# Description:

BACKUP_FILE=backup.tar.xz
LINK_TO_BACKUP=https://leosmith.xyz/rice/$BACKUP_FILE

curl $LINK_TO_BACKUP --output $PWD/$BACKUP_FILE
tar -xf $BACKUP_FILE
#mkarchiso -v -w /tmp/live_workdir/ $PWD/archlive/
