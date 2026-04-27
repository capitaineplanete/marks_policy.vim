# marks_policy.vim

by default `m` works everywhere. you lock files explicitly, and they stay locked across sessions.

locked files remap `m` to `` ` `` so you can still jump to marks, just not set them.

## install

drop `marks_policy.vim` in your plugin directory. for XDG setups that's `$XDG_CONFIG_HOME/vim/plugin/`.

## usage

| mapping | does |
|---|---|
| `<leader>mt` | toggle lock on current file |
| `<leader>ms` | show lock status of current file |

## data

locked file paths are stored in `marks_locked.txt` in the first entry of your `runtimepath`. usually `~/.vim/` or `$XDG_CONFIG_HOME/vim/`. plain text, one path per line, hand-editable.
