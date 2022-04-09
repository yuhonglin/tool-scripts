get_script_full_dir () {
    realpath "$( dirname -- "${BASH_SOURCE[0]}" )"
}

get_git_repo_full_dir () {
    # We currently put all scripts in the root dir of the repo.
    get_script_full_dir
}

get_emacsd_data_dir () {
    echo `get_script_full_dir`/data/emacs.d/
}

get_emacsd_use_package_dir () {
    echo `get_script_full_dir`/data/emacs.d/use-package
}

pull_submodule_if_needed () {
    echo "> Updating submodules..."
    # We always try to do it because currently the submodules are small.
    pushd `get_git_repo_full_dir`  > /dev/null
    git pull --recurse-submodules
    popd > /dev/null
    echo "> Done"
}

get_time_string () {
    date '+%Y-%m-%d-%H-%M-%S'
}

# Returns the directory where source-based pacakges are installed.
get_source_dir () {
    echo "$HOME/Source/"
}

get_ccls_dir () {
    echo `get_source_dir`/ccls
}

backup_folder () {
    local full_path="$(realpath $1)"
    local dt=`get_time_string`
    local backup_folder="${full_path}-${dt}"
    echo "> Rename ${full_path} to ${backup_folder}"
    mv "${full_path}" "${backup_folder}"
}
