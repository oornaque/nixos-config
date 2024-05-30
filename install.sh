#/bin/sh

nix-shell -p git
git clone https://github.com/oornaque/nixos-config
cd nixos-config
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk-config.nix
# enter luks password
sudo nixos-generate-config --no-filesystems --root /mnt
cp *.nix /mnt/etc/nixos
cd /mnt/etc/nixos
nixos-install --flake .#main