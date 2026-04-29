
### What is this?
*Optometric* is a modified recovery image with a bunch of **utilites** ported from [Priism](https://github.com/xmb9/Priism) and [Aurora](https://github.com/AerialiteLabs/aurora). The original badsilver source code was forked from [Moonsploit](https://github.com/Moonsploit), who partially vibecoded it (he forked from badrecovery).

### Building:
```bash
git clone https://github.com/vibec3der/optometric
cd optometric
sudo bash buildfull_optometric.sh <board>
```
(Example for the corsola board)
```bash
git clone https://github.com/vibec3der/optometric
cd optometric
sudo bash buildfull_optometric.sh corsola
```

## Images
None yet, I'm still testing with the script

## Flashing:
Flash with any tool (Rufus, dd, cru, balenaetcher, etc) and select the file as the item to flash to [your usb/sd card]

### I have flashed a usb drive or sd card, what now?
Complete sh1ttyexec, then enter developer mode and recover to your usb, and now you have a bunch of utility options.
### Credits:

[BinBashBanana](https://github.com/binbashbanana) - badrecovery

[crosbreaker](https://github.com/crosbreaker) - badbr0ker

[Xmb9, soap-phia](https://github.com/xmb/Priism) - ported features

[Aerialite Labs](https://github.com/AerialiteLabs/aurora) - ported features

[emery](https://github.com/emerwyi) - finding quicksilver
