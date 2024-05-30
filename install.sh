#/bin/sh

nix-shell -p git
git clone https://github.com/oornaque/nixos-config
cd nixos-config
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk-config.nix
# enter luks password
sudo nixos-generate-config --no-filesystems --root /mnt
sudo cp *.nix /mnt/etc/nixos
cd /mnt/etc/nixos
sudo nixos-install --flake .#main
sudo nixos-rebuild switch --flake .#main
reboot
