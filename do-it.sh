#!/bin/bash

# TODO: Detect when rate limit is hit

# VARS
# Change to your wishes
MAX=100

# SETUP / BOOTSTRAP / PREPARE
mkdir -p logs

# Find all notes to dump
# FIXME: We must check if ratelimit is hit here!
geeknote find --count $MAX

START=1
END=$MAX
for ((i=$START; i<=$END; i++)); do
    echo "Beginning to dump note number #$i..."   # ...with date $date
    file=logs/$i.md    # Replace index with date and timestamp, or at the very least date
    geeknote show $i > $file

    # Check if rate limit is hit, and if it is, figure out the sleep duration.
    sleep_duration=$(cat $file | egrep "Rate Limit Hit: Please wait [0-9]* seconds before continuing" | egrep -o --color=never "[0-9]*")

    if [[ ! -z $sleep_duration ]]; then
        # Sleep limit was obviously hit because a required sleep duration was aquired.
        # TODO: Decrement $i here to retry after waiting! Or extract inner contents of loop as function and simply call again after waiting.
        echo "Rate limit reached, waiting $sleep_duration seconds as promised..."
        sleep $sleep_duration;
    fi

    echo "Dumped note with filename $file, continuing..."
done

