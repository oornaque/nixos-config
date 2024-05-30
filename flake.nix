{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, disko, ... }: {
    # Available through 'nixos-rebuild --flake .#main'
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/flake.nix#L21
      system = "x86_64-linux";
      modules = [ disko.nixosModules.disko ./disk-config.nix ./configuration.nix ];
    };

    # Available through 'home-manager --flake .#user'
    homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
      # Home-manager requires 'pkgs' instance
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./home.nix ];
    };
  };
}
