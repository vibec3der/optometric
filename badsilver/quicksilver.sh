#!/bin/bash
echo "badsilver - kv6 unenrollment for keyrolled devices"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "1) Unenroll"
echo "2) Re-enroll"
read -p "Choose option: " choice

case $choice in
    1)
        echo "Generating re-enrollment key..."
        if vpd -i RW_VPD -s "re_enrollment_key=$(openssl rand -hex 32)"; then
            echo "Unenrollment complete!"
        else
            echo "Failed to set re-enrollment key"
            exit 1
        fi
        ;;
    2)
        if vpd -i RW_VPD -d "re_enrollment_key"; then
            echo "Re-enrollment complete!"
        else
            echo "Failed to remove re-enrollment key"
            exit 1
        fi
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac
echo ""
echo "Important: Reboot and exit developer mode when done."
read -p "Press Enter to reboot..."
reboot
