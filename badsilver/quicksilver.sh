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
            if vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"; then
                echo "Unenrollment success!"
                echo "Returning to menu in 3 seconds..."
                sleep 3
            else
                echo "Error: failed to set re_enrollment_key"
                echo "Returning to menu in 3 seconds..."
                sleep 3
            fi
            ;;
        2)
            if vpd -i RW_VPD -d "re_enrollment_key"; then
                echo "Reenrollment success!"
                echo "Returning to menu in 3 seconds..."
                sleep 3
            else
                echo "Error: failed to delete re_enrollment_key"
                echo "Returning to menu in 3 seconds..."
                sleep 3
            fi
            ;;
        3)
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
