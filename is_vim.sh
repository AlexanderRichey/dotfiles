#!/bin/zsh

pane_pid=$(tmux display -p "#{pane_pid}")

[ -z "$pane_pid" ] && exit 1 

# Retrieve all descendant processes of the tmux pane's shell by iterating through the process tree.
# This includes child processes and their descendants recursively.
descendants=$(ps -eo pid=,ppid=,stat= | awk -v pid="$pane_pid" '{
    if ($3 !~ /^T/) {
        pid_array[$1]=$2
    }
} END {
    for (p in pid_array) {
        current_pid = p
        while (current_pid != "" && current_pid != "0") {
            if (current_pid == pid) {
                print p
                break
            }
            current_pid = pid_array[current_pid]
        }
    }
}')

if [ -n "$descendants" ]; then

    descendant_pids=$(echo "$descendants" | tr '\n' ',' | sed 's/,$//')

    ps -o args= -p "$descendant_pids" | grep -iqE "(^|/)([gn]?vim?x?)(diff)?"

    if [ $? -eq 0 ]; then
        exit 0
    fi
fi

exit 1
