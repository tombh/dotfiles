def git_current_branch [] {
  git branch --show-current | str trim -c "\n"
}

alias s = git status -sb
alias g = git
alias ga = git add
alias gaa = git add --all
alias gapa = git add --patch
alias gau = git add --update
alias gb = git branch
alias gba = git branch -a
alias gbd = git branch -d
alias gbl = git blame -b -w
alias gbnm = git branch --no-merged
alias gbr = git branch --remote
alias gbs = git bisect
alias gbsb = git bisect bad
alias gbsg = git bisect good
alias gbsr = git bisect reset
alias gbss = git bisect start
alias gc = git commit -v
alias gc! = git commit -v --amend
alias gca = git commit -v -a
alias gca! = git commit -v -a --amend
alias gcam = git commit -a -m
alias gcan! = git commit -v -a --no-edit --amend
alias gcans! = git commit -v -a -s --no-edit --amend
alias gcb = git checkout -b
alias gcd = git checkout develop
alias gcf = git config --list
alias gcl = git clone --recursive
alias gclean = git clean -fd
alias gcm = git checkout master
alias gcmsg = git commit -m
alias gcn! = git commit -v --no-edit --amend
alias gco = git checkout
alias gcount = git shortlog -sn
alias gcp = git cherry-pick
alias gcpa = git cherry-pick --abort
alias gcpc = git cherry-pick --continue
alias gcs = git commit -S
alias gcsm = git commit -s -m
alias gd = git diff
alias gds = git diff --staged
alias gdt = git diff-tree --no-commit-id --name-only -r
alias gdw = git diff --word-diff
alias gf = git fetch
alias gfa = git fetch --all --prune
alias gfo = git fetch origin
alias gg = git gui citool
alias gga = git gui citool --amend
alias ggpull = git pull origin (git_current_branch)
alias ggpur = ggu
alias ggpush = git push origin (git_current_branch)
alias ggsup = git branch --set-upstream-to=origin/(git_current_branch)
alias ghh = git help
alias gignore = git update-index --assume-unchanged
alias gk = gitk --all --branches
alias gke = gitk --all (git log -g --pretty=%h)
alias gl = git pull
alias glg = git log --stat
alias glgg = git log --graph
alias glgga = git log --graph --decorate --all
alias glgm = git log --graph --max-count=10
alias glgp = git log --stat -p
alias glo = git log --oneline --decorate
alias globurl = noglob urlglobber
alias glog = git log --oneline --decorate --graph
alias gloga = git log --oneline --decorate --graph --all
alias glol = git log --graph --pretty=\%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\ --abbrev-commit
alias glola = git log --graph --pretty=\%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\ --abbrev-commit --all
alias glp = _git_log_prettily
alias glum = git pull upstream master
alias gm = git merge
alias gmom = git merge origin/master
alias gmt = git mergetool --no-prompt
alias gmtvim = git mergetool --no-prompt --tool=vimdiff
alias gmum = git merge upstream/master
alias gp = git push
alias gpf = git push --force-with-lease --force-if-includes
alias gpd = git push --dry-run
def gpoat [...tags] {
	git push origin --all
	git push origin --tags ...$tags
}
def gpristine [] {
	git reset --hard
	git clean -dfx
}
alias gpsup = git push --set-upstream origin (git_current_branch)
alias gpu = git push upstream
alias gpv = git push -v
alias gr = git remote
alias gra = git remote add
alias grb = git rebase
alias grba = git rebase --abort
alias grbc = git rebase --continue
alias grbi = git rebase -i
alias grbm = git rebase master
alias grbs = git rebase --skip
alias grep = grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}
alias grh = git reset HEAD
alias grhh = git reset HEAD --hard
alias grmv = git remote rename
alias grrm = git remote remove
alias grset = git remote set-url
alias grt = cd (git rev-parse --show-toplevel or echo ".")
alias gru = git reset --
alias grup = git remote update
alias grv = git remote -v
alias gsb = git status -sb
alias gsd = git svn dcommit
alias gsi = git submodule init
alias gsps = git show --pretty=short --show-signature
alias gsr = git svn rebase
alias gss = git status -s
alias gst = git status
alias gsta = git stash save
alias gstaa = git stash apply
alias gstc = git stash clear
alias gstd = git stash drop
alias gstl = git stash list
alias gstp = git stash pop
alias gsts = git stash show --text
alias gsu = git submodule update
alias gts = git tag -s
def gtv [] {
	git tag | sort
}
alias gunignore = git update-index --no-assume-unchanged
alias gup = git pull --rebase
alias gupv = git pull --rebase -v
alias gwch = git whatchanged -p --abbrev-commit --pretty=medium
