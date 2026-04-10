
### What is this?
(Fork of moonsploit's vibecoded badsilver) This is a port of aurora features to a modified chromeos recovery image that can be booted on **keyrolled** devices

### Building:
```bash
git clone https://github.com/vibec3der/optometric
cd optometric
sudo bash buildfull_optometric.sh <board>
```
## Images
None yet, I'm still testing with the script

## Flashing:
Flash with any tool (Rufus, dd, cru, balenaetcher) and select the file as the item to flash to [your usb/sd card]

### I have flashed a usb drive or sd card, what now?
Complete sh1ttyexec, then enter developer mode and recover to your usb, choose to unenroll or reenroll, then reboot and disable developer mode. When you setup it will be unenrolled.
### Credits:

[BinBashBanana](https://github.com/binbashbanana) - badrecovery

[crosbreaker](https://github.com/crosbreaker) - badbr0ker

[Xmb9, soap-phia](https://github.com/xmb/Priism) - ported features

[Aerialite Labs](https://github.com/AerialiteLabs/aurora) - ported features

[emery](https://github.com/emerwyi) - finding quicksilver
