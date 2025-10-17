### If you arent keyrolled, use regular [quicksilver](https://github.com/Moonsploit/quicksilver) instead.
# badsilver - keyrolled kv6 unenrollment
### What is this?
badsilver is quicksilver injected into badrecovery unverified, allowing for unenrollment on keyrolled kernver 6 ChromeOS devices.
### If you would like the script to do everything for you:
```bash
git clone https://github.com/Moonsploit/badsilver
cd badsilver
bash buildfull_badsilver.sh <board>
```
### If you would like to use a local recovery image:
```bash
git clone https://github.com/Moonsploit/badsilver
cd badbr0ker
sudo ./build_badrecovery.sh -i image.bin -t unverified
```
### If you are using [badrecovery](https://github.com/BinBashBanana/badrecovery) unverified:
Simply run the following in the shell to unenroll:
```bash
vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"
```
Or this to reenroll:
```bash
vpd -i RW_VPD -d "re_enrollment_key"
```
### How do I flash it to a usb drive or sd card?
Download a prebuilt from [dl.snerill.org/badsilver](https://dl.snerill.org/badsilver), or build an image yourself with the above commands.  Flash it using the [Chromebook Recovery Utility](https://chromewebstore.google.com/detail/chromebook-recovery-utili/pocpnlppkickgojjlmhdmidojbmbodfm), or anything else that flashes images to USB drives and sd cards, such as [balenaEtcher](https://etcher.balena.io/), [dd](https://en.wikipedia.org/wiki/Dd_(Unix)) or [rufus](https://rufus.ie/en/)
### I have flashed a usb drive or sd card, what now?
Complete [???](https://github.com/crosbreaker/???), then enter developer mode and recover to your usb, choose to unenroll or reenroll, then reboot and disable developer mode. When you setup it will be unenrolled.
### Credits:
[HarryTarryJarry](https://github.com/HarryTarryJarry) - All badbr0ker development

[BinBashBanana](https://github.com/binbashbanana) - badrecovery

[Crossjbly](https://github.com/crossjbly) - Fixing a few things [badbr0ker]

[codenerd](https://github.com/codenerd87) - adding more board support (everything but nissa, dedede and corsola) [badbr0ker]

[emery](https://github.com/emerwyi) - finding quicksilver

[Moonsploit](https://github.com/Moonsploit) - All badsilver development

[crosbreaker](https://github.com/crosbreaker) - ???
