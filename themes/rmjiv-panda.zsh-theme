# the svn plugin has to be activated for this to work.

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}$(svn_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%} ✗ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "



ZSH_PROMPT_BASE_COLOR="%{$fg_bold[blue]%}"
ZSH_THEME_REPO_NAME_COLOR="%{$fg_bold[red]%}"

ZSH_THEME_SVN_PROMPT_PREFIX="svn:("
ZSH_THEME_SVN_PROMPT_SUFFIX=")"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[red]%} ✘ %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" "

add-zsh-hook precmd  findtrtop_precmd
function findtrtop_precmd {
        candidate=`pwd`
        while true; do
                if [[ -e "$candidate/GNUmaster" &&  -e "$candidate/tr" && -e "$candidate/Crawlers" ]]; then
                        trtop $candidate
                        break;
                else
                        nextcandidate=${candidate%/*}
                        if [[ "v$nextcandidate" == "v$candidate" || "v$nextcandidate" == "v" ]]; then
                                break;
                        fi
                        candidate=$nextcandidate;
                fi
        done
}
function trtop {
        if (( $# == 1 )); then
                oldscripts=$TRTOP/scripts
                export TRTOP=$1
                export PATH=${PATH//:$oldscripts}:$TRTOP/scripts
                # Added the following to save the latest TRTOP to a file
                echo $TRTOP > ~/.trtop_save
        else
                echo $TRTOP
        fi

}