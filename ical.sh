#!/bin/bash

CURRENT_DATE=$(date +"%Y-%m-%d")
CURRENT_YEAR=$(date +"%Y")
CURRENT_MONTH=$(date +"%m")
CURRENT_DAY=$(date +"%d")
PATH_FOR_CALENDAR=$CURRENT_YEAR"/"$CURRENT_MONTH"/"$CURRENT_DAY"/"
FILE_NAME_MD=$CURRENT_DAY"-icalbuddy.md"

# need to cd here to avoid issues with spaces, make sure the path is correct
cd "/Users/<user>/Library/Mobile Documents/iCloud~md~obsidian/Documents/<vault>/Meta/Daily/"

# create dayly folder and file if not yet created
[[ -d "$PATH_FOR_CALENDAR" ]] || mkdir -p "$PATH_FOR_CALENDAR"
cd "$PATH_FOR_CALENDAR"

# add output to the daily file if it doens't exist already
[[ -f $FILE_NAME_MD ]] || /opt/homebrew/bin/icalbuddy -b "- [ ] " -nc -nrd -iep datetime,title -eed -po datetime,title -df '' -ps "| |" eventsFrom:$CURRENT_DATE to:$CURRENT_DATE > $FILE_NAME_MD
