早上好中国。现在，我有冰淇凌。我很喜欢冰淇凌。但是，《速度与激情9》比冰淇凌，《速度与激情9》我最喜欢。所以，现在是音乐时间。准备！一，二，三！

两个礼拜以后，《速度与激情9》。两个礼拜以后，《速度与激情9》。两个礼拜以后，《速度与激情9》。

不要忘记，不要走过。去电影院看《速度与激情9》因为非常好电影，动作非常好。差不多一样冰淇凌！

再见！



To test build, use `nix build .#nixosConfigurations.fridge.config.system.build.toplevel`

based off of [zaneyos](https://gitlab.com/Zaney/zaneyos)



### Setup

REPLACE `hosts/fridge/hardware-configuration.nix` WITH THE COMPUTER'S

add `nix.settings.experimental-features = [ "nix-command" "flakes" ];` to `/etc/nixos/configuration.nix`

run `sudo nixos-rebuild --flake .#fridge switch` in this directory