# dotfiles

![](https://imgs.xkcd.com/comics/borrow_your_laptop.png)

This project is obviously not meant to be forked...

## Bootstrap

From a very basic Arch Linux installation (base, base-devel, git, python),
this is how I bootstrap my environment:

```
pacman -Syu
bash <(curl -fsL "https://raw.githubusercontent.com/ThomasFerreira/dotfiles/master/tools/bootstrap.sh")
systemctl reboot
```
