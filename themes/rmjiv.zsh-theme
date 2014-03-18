local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

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
