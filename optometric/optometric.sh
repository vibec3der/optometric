#!/bin/bash

while true; do
    clear
    echo ""
    echo " ██████╗ ██████╗ ████████╗ ██████╗ ███╗   ███╗███████╗████████╗██████╗ ██╗ ██████╗"
    echo "██╔═══██╗██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║██╔════╝"
    echo "██║   ██║██████╔╝   ██║   ██║   ██║██╔████╔██║█████╗     ██║   ██████╔╝██║██║     "
    echo "██║   ██║██╔═══╝    ██║   ██║   ██║██║╚██╔╝██║██╔══╝     ██║   ██╔══██╗██║██║     "
    echo "╚██████╔╝██║        ██║   ╚██████╔╝██║ ╚═╝ ██║███████╗   ██║   ██║  ██║██║╚██████╗"
    echo " ╚═════╝ ╚═╝        ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝ ╚═════╝"
    echo "               kv6 unenrollment tooling created by vibec3der"
    echo "    All credit for quicksilver and utilities goes to emerwyi and creators"
    echo ""
 
    echo "1) Unenroll"
    echo "2) Reenroll"
    echo "3) Payloads"
    echo "4) Shell"
    echo "5) Reboot"
    read -p "Choose option: " choice

    case $choice in
        1)
            vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)" 2>/dev/null
            echo "Unenrollment complete!"
            read -p "Press Enter to return to menu..."
            ;;
        2)
            vpd -i RW_VPD -d "re_enrollment_key" 2>/dev/null
            echo "Reenrollment complete!"
            read -p "Press Enter to return to menu..."
            ;;
        3)  # very minimal payloads option (coded by me) w/ some help from chatgpt
            while true; do
            clear
            echo "= Payloads ="
            echo ""
            selpayload=(/usb/payloads/*.sh)
            if [ ! -e "${selpayload[0]}" ]; then
                echo "No payloads found in /usb/payloads/ :("
                echo ""
                read -p "Press Enter to go back.."
                break
            fi
              for i in "${!selpayload[@]}"; do
            echo "$((i+1))) $(basename "${selpayload[i]}")"
        done
            echo "0) Back"
        echo ""
        echo "press 0 to go back"
        echo ""

        read -p "Choose payload: " pchoice

        
        if [ "$pchoice" = "0" ]; then
            break
        fi

        index=$((pchoice-1))

        
        if [ -n "${selpayload[index]}" ]; then
            echo "Running $(basename "${selpayload[index]}")..."
            bash "${selpayload[index]}"
            echo ""
            read -p "Press Enter to return to the payloads menu..."
        else
            echo "Invalid choice"
            read -p "Press Enter.."
        fi
    done
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
            read -p "Press Enter to return to menu..."
            ;;
    esac
    # Board-indentifying taken from https://github.com/xmb/Priism (prism.sh)
    board_name="$(cat /sys/devices/virtual/dmi/id/board_name | head -n 1)"
if ! [ $? -eq 0 ]; then
	echo -e "${COLOR_YELLOW_B}Board name detection failed. Pls report.${COLOR_RESET}"
 	board_name=""
fi
done
