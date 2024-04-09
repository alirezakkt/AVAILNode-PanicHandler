#!/bin/bash

LOG_FILE="/var/log/auto_restart.log"
COMMAND="curl -sL1 http://avail.sh | bash -s -- --identity .avail/identity/identity.toml"
RESTART_DELAY=5

while true; do
    echo "$(date +"%Y-%m-%d %T") - Starting process..." >> "$LOG_FILE"

    # Execute the command and capture its output
    output=$(eval "$COMMAND" 2>&1)

    # Check if the command failed
    if [ $? -ne 0 ]; then
        echo "$(date +"%Y-%m-%d %T") - Process crashed. Restarting..." >> "$LOG_FILE"
    else
        echo "$(date +"%Y-%m-%d %T") - Process completed successfully." >> "$LOG_FILE"
    fi

    # Log the output of the command
    echo "$output" >> "$LOG_FILE"

    sleep "$RESTART_DELAY"
done
