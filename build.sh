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

BACKUP_FILE=./backup.tar.xz
LINK_TO_BACKUP=https://leosmith.xyz/rice/$BACKUP_FILE
HOME_ARCHLIVE=./archlive/airootfs/root
ROOT_ARCHLIVE=./archlive/airootfs
BIN_ARCHLIVE=./archlive/airootfs/usr/local/bin
BACKUP_FOLDER=./backup/
SOURCE_FOLDER=./backup/.source
DWM_FOLDER=$SOURCE_FOLDER/dwm-6.2
ST_FOLDER=$SOURCE_FOLDER/st-0.8.2
DMENU_FOLDER=$SOURCE_FOLDER/dmenu-4.9
WMNAME_FOLDER=$SOURCE_FOLDER/wmname
XMENU_FOLDER=$SOURCE_FOLDER/xmenu

# Download backup
curl $LINK_TO_BACKUP --output $PWD/$BACKUP_FILE
tar -xf $BACKUP_FILE

# compile programs
make -C $DWM_FOLDER
make -C $ST_FOLDER
make -C $DMENU_FOLDER
make -C $WMNAME_FOLDER
make -C $XMENU_FOLDER

# move binaries in specific folders
cp -r $DWM_FOLDER/dwm $BIN_ARCHLIVE
cp -r $DWM_FOLDER/dwm-light $BIN_ARCHLIVE
cp -r $ST_FOLDER/st $BIN_ARCHLIVE
cp -r $DMENU_FOLDER/dmenu $BIN_ARCHLIVE
cp -r $DMENU_FOLDER/dmenu_run $BIN_ARCHLIVE
cp -r $DMENU_FOLDER/stest $BIN_ARCHLIVE
cp -r $WMNAME_FOLDER/wmname $BIN_ARCHLIVE
cp -r $XMENU_FOLDER/xmenu $BIN_ARCHLIVE
cp -r $XMENU_FOLDER/xmenu_run $BIN_ARCHLIVE
# Remove makefile to remove clutter
rm -rf $SOURCE_FOLDER/scripts/Makefile
#move all scripts into bin
cp -r $SOURCE_FOLDER/scripts/* $BIN_ARCHLIVE

# move config
cp -r $BACKUP_FOLDER/.bashrc $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.vimrc $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.vim/ $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.tmux.conf $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.tmux/ $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.wallpaper.png $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.inputrc $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.conkyrc $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.fzf/ $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.dwm/ $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.tint2rc $HOME_ARCHLIVE
cp -r $BACKUP_FOLDER/.tigrc $HOME_ARCHLIVE

# move fonts
cp -r $BACKUP_FOLDER/.dwm/fonts/* $ROOT_ARCHLIVE/usr/share/fonts

# setup for startx
[ ! -f $HOME_ARCHLIVE/.xinitrc ] && echo "exec dwm" > $HOME_ARCHLIVE/.xinitrc

# Last step build iso
whoami
mkarchiso -v -w /build_dir/ $PWD/archlive/

echo "All done :)"

exit 0
