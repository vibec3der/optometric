#!/bin/bash

while true; do
    clear
    echo ""
    echo " ██████╗  █████╗ ██████╗ ███████╗██╗██╗    ██╗   ██╗███████╗██████╗ "
    echo " ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║    ██║   ██║██╔════╝██╔══██╗"
    echo " ██████╔╝███████║██║  ██║███████╗██║██║    ██║   ██║█████╗  ██████╔╝"
    echo " ██╔══██╗██╔══██║██║  ██║╚════██║██║██║    ╚██╗ ██╔╝██╔══╝  ██╔══██╗"
    echo " ██████╔╝██║  ██║██████╔╝███████║██║███████╗╚████╔╝ ███████╗██║  ██║"
    echo " ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚══════╝ ╚═══╝  ╚══════╝╚═╝  ╚═╝"
    echo "               kv6 unenrollment for keyrolled devices"
    echo "             All credit for quicksilver goes to emerwyi"
    echo ""

    echo "1) Unenroll"
    echo "2) Reenroll"
    echo "3) Shell"
    echo "4) Reboot"
    read -p "Choose option: " choice

    case $choice in
        1)
            vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"
            echo "Unenrollment complete!"
            echo "Returning to menu in 3 seconds..."
            sleep 3
            ;;
        2)
            vpd -i RW_VPD -d "re_enrollment_key"
            echo "Reenrollment complete!"
            echo "Returning to menu in 3 seconds..."
            sleep 3
            ;;
        3)
            echo "type 'exit' to go back to main menu"
            /bin/sh
            ;;
        4)
            reboot -f
            ;;
        *)
            echo "Invalid option, please try again..."
            sleep 3
            ;;
    esac
done
