alias docker-maas="$HOME/docker/scripts/start-maas-postgres-rabbit.sh"
alias docker-sonar="$HOME/docker/scripts/start-sonar-w-postgres.sh"
alias t="$TODO_DIR/cli/todo.sh -at -d $TODO_DIR/cli/todo.cfg"
alias ti="t addi"
alias todo-work="t watch lsp a-c \"@work\|@computer\|@internet\|@phone -@habit\""
alias todo-personal="t watch lsp a-c \"@home\|@city\""
alias todo-birthdays="t -x ls +birthdays | grep $1"
alias add-note="$USEFUL_SCRIPTS/bash/create-vim-note.sh $1"
alias add-diary="$USEFUL_SCRIPTS/bash/create-diary-note.sh $1"
alias update-exit="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && shutdown -P now"
alias vim-notes="(cd $PERSONAL_WIKI && vim)"
alias dc="docker-compose"
alias todo-inbox="t archive && sed -i -e 's/^[^(].*/(I) &/' $TODO_DIR/todo.txt && t -x lsp i"
alias dc-rm-networks="$USEFUL_SCRIPTS/bash/remove-docker-bridges.sh"
