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
    echo "3) Boot CKAUB"
    echo "4) Shell"
    echo "5) Reboot"
    read -p "Choose option: " choice

    case $choice in
        1)
            echo "Generating re_enrollment_key..."
            if vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)" 2>/dev/null; then
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
            echo "Removing re_enrollment_key..."
            if vpd -i RW_VPD -d "re_enrollment_key" 2>/dev/null; then
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
            sh /usb/usr/sbin/ckaub.sh
            ;;
        4)
            echo "type 'exit' to go back to main menu"
            /bin/sh
            ;;
        5)
            reboot -f
            ;;
        *)
            echo "Invalid option, please try again..."
            sleep 3
            ;;
    esac
done
