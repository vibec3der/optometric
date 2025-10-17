#!/bin/bash
clear
echo ""
echo " ██████╗  █████╗ ██████╗ ███████╗██╗██╗    ██╗   ██╗███████╗██████╗ "
echo " ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║    ██║   ██║██╔════╝██╔══██╗"
echo " ██████╔╝███████║██║  ██║███████╗██║██║    ██║   ██║█████╗  ██████╔╝"
echo " ██╔══██╗██╔══██║██║  ██║╚════██║██║██║    ╚██╗ ██╔╝██╔══╝  ██╔══██╗"
echo " ██████╔╝██║  ██║██████╔╝███████║██║███████╗╚████╔╝ ███████╗██║  ██║"
echo " ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚══════╝ ╚═══╝  ╚══════╝╚═╝  ╚═╝"
echo "               kv6 unenrollment for keyrolled devices"
echo ""

echo "1) Unenroll"
echo "2) Re-enroll"
read -p "Choose option: " choice

case $choice in
    1)
        echo "Generating re-enrollment key..."
        if vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"; then
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
