alias s = sudo --preserve-env=PATH --preserve-env=HOME env
alias se = sudoedit

alias dI = sudo dnf install -y
alias dR = sudo dnf remove
alias dU = sudo dnf upgrade --refresh

alias nI = tbx nix_install
alias nR = nix-env --uninstall
alias nU = nix-env --upgrade

alias less = less -r
alias ff = fd . -type f -name
alias be = bundle exec
alias kc = kubectl
alias grbim = ~/bin/tbx git_rebase_interactive_detect_base
alias gs = git status -u
alias o = handlr open
alias e = nvim

alias laa = lsd --long --git --almost-all
# alias lad = la --sort time
# alias las = la --sort size

def la [path?] {
    (
        ^lsd
        --blocks date,user,size,name
        --group-dirs first
        --date relative
        --sort time
        --reverse
        --almost-all
    )
}
