#!/bin/bash
clear
echo "=== ChromeOS Kernel Version Block (CKAUB) Script ==="
echo "Made by Lxrd and Codenerd, with credits to Con for finding a new way to powerwash with daub using lvm and fanq for helping with the script + emotional support"
echo "Credits to Kxtz for the original idea of KAUB. He had KAUB before but he never released it, we just managed to find it ourselves"
echo "Brought to you by crosbreaker team, crosbreaker.dev"
echo "WARNING: This will modify your Chromebook partitions."

get_largest_block_dev(){
    # return largest mmcblk device or first block device
    dev=$(lsblk -b -dn -o NAME,SIZE | awk '$1 ~ /^mmcblk/ {print $1" "$2}' | sort -k2 -nr | head -n1 | awk '{print "/dev/"$1}')
    if [ -z "$dev" ]; then
        first=$(lsblk -dn -o NAME | head -n1)
        dev="/dev/$first"
    fi
    echo "$dev"
}

# get main block device
BLOCK_DEV=$(get_largest_block_dev)
echo "Detected block device: $BLOCK_DEV"

block_kernel_updates() {
    echo "=== Block Kernel Version Updates ==="
    echo "Cloning rootfs partition (p2 -> p12)..."
    dd if=${BLOCK_DEV}p2 of=${BLOCK_DEV}p12 status=progress oflag=direct

    echo "Updating GPT priority flags..."
    cgpt add ${BLOCK_DEV} -P15 -T15 -S1 -R1 -i 2
    cgpt add ${BLOCK_DEV} -P14 -T14 -S1 -R1 -i 4
    cgpt add ${BLOCK_DEV} -P1  -T1  -S1 -R1 -i 12

    echo "Launching fdisk to delete partitions 4 and 5..."
    fdisk ${BLOCK_DEV} <<EOF
d
4
d
5
w
EOF

    echo "Flashing recovery partitions from USB..."

    # Flash partition p2
    attempts=0
    max_attempts=3
    while [ $attempts -lt $max_attempts ]; do
        echo "Please enter the dd command to flash partition ${BLOCK_DEV}p2 from your USB device:"
        read manual_input

        if [[ $manual_input =~ ^dd\ if=/dev/sd[a-zA-Z0-9]+.*\ of=/dev/mmcblk[0-9]+p2 ]]; then
            eval $manual_input
            dd_status=$?

            if [ $dd_status -eq 0 ]; then
                echo "Recovery partition p2 flashed successfully."
                break
            else
                echo "Error: dd command failed."
                let attempts++
                if [ $attempts -ge $max_attempts ]; then
                    echo "Maximum attempts reached. Aborting."
                    return
                fi
            fi
        elif [[ $manual_input =~ ^lsblk ]]; then
            eval $manual_input
        else
            echo "Invalid command. Please enter the correct dd command to flash the partition."
        fi
    done

    # Flash partition p3
    attempts=0
    while [ $attempts -lt $max_attempts ]; do
        echo "Please enter the dd command to flash partition ${BLOCK_DEV}p3 from your USB device:"
        read manual_input

        if [[ $manual_input =~ ^dd\ if=/dev/sd[a-zA-Z0-9]+.*\ of=/dev/mmcblk[0-9]+p3 ]]; then
            eval $manual_input
            dd_status=$?

            if [ $dd_status -eq 0 ]; then
                echo "Recovery partition p3 flashed successfully."
                break
            else
                echo "Error: dd command failed."
                let attempts++
                if [ $attempts -ge $max_attempts ]; then
                    echo "Maximum attempts reached. Aborting."
                    return
                fi
            fi
        elif [[ $manual_input =~ ^lsblk ]]; then
            eval $manual_input
        else
            echo "Invalid command. Please enter the correct dd command to flash the partition."
        fi
    done

    echo "Formatting stateful partition..."
    mkfs.ext4 ${BLOCK_DEV}p1

    # disable dev mode req
    crossystem disable_dev_request=1

    # update gpt
    echo "Updating GPT flags again..."
    cgpt add ${BLOCK_DEV} -P15 -T15 -S1 -R1 -i 2
    cgpt add ${BLOCK_DEV} -P1  -T1  -S1 -R1 -i 12

    sync && sync

    # kernel gpt entry
    cgpt add ${BLOCK_DEV} -P14 -T14 -S1 -R1 -i 12 -t kernel

    echo "===================================================="
    echo "You are now CKAUBBED."
    echo "Kernel version updates will be blocked on recovery or updates."
    echo "Normal ChromeOS updates will NOT work."
    echo ""
    echo "⚠ DO NOT powerwash in normal ChromeOS UI!"
    echo "Use the 'Powerwash' option in this menu instead."
    echo "===================================================="
    sleep 7
}

unblock_kernel_updates() {
    echo "=== Unblock Kernel Version Updates ==="
    echo "Restoring normal GPT flags..."
    cgpt add ${BLOCK_DEV} -P0 -T0 -S0 -R0 -i 12
    cgpt add ${BLOCK_DEV} -P0 -T0 -S0 -R0 -i 4
    
    echo "Normal update functionality has been restored."
    echo "You can now update ChromeOS normally."
}

powerwash() {
    echo "=== Powerwash ==="
    echo "Formatting stateful partition..."
    mkfs.ext4 ${BLOCK_DEV}p1
    
    echo "Powerwash completed successfully."
    echo "All user data has been erased."
}

show_menu() {
    while true; do
        echo ""
        echo " ██████╗  █████╗ ██████╗ ███████╗██╗██╗    ██╗   ██╗███████╗██████╗ "
        echo " ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║    ██║   ██║██╔════╝██╔══██╗"
        echo " ██████╔╝███████║██║  ██║███████╗██║██║    ██║   ██║█████╗  ██████╔╝"
        echo " ██╔══██╗██╔══██║██║  ██║╚════██║██║██║    ╚██╗ ██╔╝██╔══╝  ██╔══██╗"
        echo " ██████╔╝██║  ██║██████╔╝███████║██║███████╗╚████╔╝ ███████╗██║  ██║"
        echo " ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚══════╝ ╚═══╝  ╚══════╝╚═╝  ╚═╝"
        echo "              ckaub - kernver automatic update blocking"
        echo ""

        echo "1) Block Kernel Version Updates"
        echo "2) Unblock Kernel Version Updates" 
        echo "3) Powerwash"
        echo "4) Exit"
        echo ""

        read -p "Select an option (1-4): " choice

        case $choice in
            1)
                block_kernel_updates
                ;;
            2)
                unblock_kernel_updates
                ;;
            3)
                powerwash
                ;;
            4)
                sh /usb/usr/sbin/badsilver.sh
                ;;
            *)
                echo "Invalid option, please try again..."
                sleep 3
                ;;
        esac
    done
}

# Start the menu
show_menu
