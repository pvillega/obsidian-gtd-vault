# Obsidian GTD Vault

This contains a vault with the basics of my GTD implementation. The vault tries to facilitate the GTD process, and adds mechanisms to pull daily tasks from projects and lists, and the calendar.
This is very opinionated, but it may be useful to someone.

## Calendar extraction

Due to a current issue with permissions in Obsidian, it requires the use of the `ical.sh` script to pull the calendar tasks. It only works for users of iCloud calendar.

You will need to:

- install `icalbuddy` via `brew`
- modify the script to set the right path to your vault
- run it daily to extract the tasks for the day from your calendar
