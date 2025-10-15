### badsilver
# Support
### If you would like the script to do everything for you:
```bash
git clone https://github.com/crosbreaker/badsilver
cd badbr0ker
bash buildfull_badsilver.sh <board>
```
### If you would like to use a local recovery image: (NOT IMPLEMENTED)
```bash
git clone https://github.com/crosbreaker/badsilver
cd badbr0ker
bash update_downloader.sh <board>
sudo ./build_badsilver.sh -i image.bin -t unverified
```
### What is this?
badsilver is quicksilver injected into badrecovery unverified, allowing for unenrollment on keyrolled kv6 ChromeOS devices.
### If you are on a [BadApple](https://github.com/applefritter-inc/BadApple) vulnernable device
Simply run the following in the shell to unenroll:
```bash
vpd -i RW_VPD -s "re_enrollment_key"="$(openssl rand -hex 32)"
```
Or this to reenroll:
```bash
vpd -i RW_VPD -d "re_enrollment_key"
```
### How do I make a usb?
Download a prebuilt from the [prebuilts section](#prebuilts), or build an image yourself with the above commands.  Flash it using the [Chromebook Recovery Utility](https://chromewebstore.google.com/detail/chromebook-recovery-utili/pocpnlppkickgojjlmhdmidojbmbodfm), or anything else that etches disk images to USB drives. Such as [balenaEtcher](https://etcher.balena.io/), [dd](https://wiki.archlinux.org/title/Dd) or [rufus](https://rufus.ie/en/)
### I have a usb, what now?
Complete [silverstream?](https://github.com/crosbreaker/silverstream), then enter developer mode and recover to your usb
### Prebuilts

[GitHub actions](https://dl.snerill.org/badsilver)
### Credits:
[HarryTarryJarry](https://github.com/HarryTarryJarry) - All badbr0ker development [badbr0ker]

[BinBashBanana](https://github.com/binbashbanana) - badrecovery

[Crossjbly](https://github.com/crossjbly) - Fixing a few things [badbr0ker]

[codenerd](https://github.com/codenerd87) - adding more board support (everything but nissa, dedede and corsola) [badbr0ker]
