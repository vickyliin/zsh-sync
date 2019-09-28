# Zsh Sync

Synchronize files, often user specific configurations, across different environments.

This plugin provide simple commands: `config-upload`, `config-download` to make sure
one can migrate workspace settings easily from one computer to another.

## Use case

```zsh
ZSH_SYNC_REMOTE=user@some.host
ZSH_SYNC_FILES+=(
    .vimrc
    .vim/
    .tmux.conf
    .config/tmuxline.conf
)
config-upload
```

## Setup

Download the plugin,

```
git clone https://github.com/vickyliin/zsh-sync.git ~/.oh-my-zsh/custom/plugins/zsh-sync
```

In `.zshrc`,

```
ZSH_SYNC_REMOTE=remote-hostname
plugins+=(zsh-sync)
```

### Configurations

In addition to `ZSH_SYNC_REMOTE`, the configuration variables and their default values are:

```zsh
ZSH_SYNC_REMOTE_PATH=
ZSH_SYNC_LOCAL_PATH=$HOME
ZSH_SYNC_FILES=(
    .zshrc
    .gitconfig
    .oh-my-zsh/custom/
)
```

You can override/append the variables **after** `source $ZSH/oh-my-zsh.sh` in `.zshrc`.

Make sure **folders** to sync in `ZSH_SYNC_FILES` ends with a slash (`/`).

## Usage

- `config-download`

    Download all the files specified in `$ZSH_SYNC_FILES` from `$ZSH_SYNC_REMOTE:$ZSH_SYNC_REMOTE_PATH` to `$ZSH_SYNC_LOCAL_PATH`.

- `config-upload`

    Upload all the files specified in `$ZSH_SYNC_FILES` from `$ZSH_SYNC_LOCAL_PATH` to `$ZSH_SYNC_REMOTE:$ZSH_SYNC_REMOTE_PATH`.

### Arguments

You can use any `rsync` arguments in `config-upload` and `config-download`.
`-r` is passed automatically so you don't need to add one by yourself.

### SSH Settings

These scripts use `rsync` to sync from an ssh host
so you can setup ssh keys to prevent from passwords prompt everytime:

```sh
ssh-keygen -f ~/.ssh/my_key
ssh-copy-id -i ~/.ssh/my_key user@hostname
```
