#!/bin/bash
# dis probably wont work yet cuz yk yk, vibecoded.
echo -e "${COLOR_YELLOW_B}You will not be able to return to Optometric again in this session once you do this!${COLOR_RESET}"
read -p "Press 'y' to continue: " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp /usr/sbin/sh1mmer_main_old.sh /usr/sbin/sh1mmer_main.sh

    exec /sbin/init

    # only runs if exec fails
    echo "Failed to execute /sbin/init!"
    read -p "Press Enter to continue..."
else
    echo "Cancelled."
fi