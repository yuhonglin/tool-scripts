#!/usr/bin/bash
CURRENT_DIR="$( dirname ${BASH_SOURCE[0]} )"
. "$CURRENT_DIR/common.sh"

pull_submodule_if_needed

EMACSD_PATH="$HOME/.emacs.d"
rename_emacsd () {
   local dt=`get_time_string`
   local backup_folder="~/.emacs.d-${dt}"
   echo "Rename ~/.emacs.d/ to ${backup_folder}"
   mv "$EMACSD_PATH" "${backup_folder}"
}

if [ -d "$EMACSD_PATH" ]; then
    read -p "~/.emacs.d already exists, are you sure to continue? [N/y] " -n 1 -r
    if [[ $REPLY != y ]] || [[ -z $REPLY ]]; then
       echo "> Quit."
       exit 0 
    fi
    rename_emacsd
fi

cp -r "$(get_emacsd_data_dir)" "$HOME/.emacs.d"

echo "> Now run emacs to install its packages".
