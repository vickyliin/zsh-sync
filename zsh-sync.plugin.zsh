ZSH_SYNC_REMOTE_PATH=.
ZSH_SYNC_LOCAL_PATH=$HOME
ZSH_SYNC_FILES=(
    .zshrc
    .gitconfig
    .oh-my-zsh/custom/
)

function _zsh_sync_valid(){
    if [ -z $ZSH_SYNC_REMOTE ]; then
        >&2 echo zsh-sync: You should specify a '$ZSH_SYNC_REMOTE' to use config-upload/config-download.
        return 1
    fi
}

function _zsh_sync(){
    local src="$1"
    local tar="$2"
    mkdir -p $tar
    shift 2
    for config in $ZSH_SYNC_FILES; do
        local tar_config="$tar/$config"
        mkdir -p $(dirname $tar_config)
        local sync_command="rsync -r $@ "$src/$config" "$tar_config""
        echo $sync_command
        eval $sync_command
    done
}

function config-upload(){
    _zsh_sync_valid && \
    _zsh_sync $ZSH_SYNC_LOCAL_PATH $ZSH_SYNC_REMOTE:$ZSH_SYNC_REMOTE_PATH $@
}
function config-download(){
    _zsh_sync_valid && \
    _zsh_sync $ZSH_SYNC_REMOTE:$ZSH_SYNC_REMOTE_PATH $ZSH_SYNC_LOCAL_PATH $@
}
