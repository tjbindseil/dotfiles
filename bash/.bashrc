set -o vi

export PATH="/Users/tj/Library/Android/sdk/platform-tools/:$PATH"

export WD="/Users/tj/Projects/sts_mono_repo"

alias gs='git status'
alias gd='git diff'
alias gl='git log --graph --all --decorate'
alias gri='git rebase -i'
alias scr='vim ~/.scratch.txt'
alias c='clear'
alias cc='cd $WD && clear'
alias v='vi'

# wireless android debuggin
# # plug in device
# adb tcpip 5555
# adb shell ifconfig # find ip addr
# adb connect <ip addr>:5555

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

alias ls='ls -p'

export MAIN='app/src/main/java'

# tmux source ~/.tmux.conf

# after making a venv with 'python3 -m venv ./venv'
alias venv='source venv/bin/activate'

export PATH="$PATH:$HOME/.npm-packages/bin"

export PATH="$PATH:/usr/local/bin/git"

alias sts='ssh -i ~/.ssh/sts_ec2.pem ec2-user@52.12.110.115'

alias sa='cd ~/Projects/dwf_3/webapp/my-app && npm start'

alias pypack='rm dist/* && python3 setup.py sdist bdist_wheel'
alias pyupload='python3 -m twine upload dist/*'

set GH_PW="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"
set GH_PW_2="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"

alias nv='/Users/tj/nvim-macos/bin/nvim'
