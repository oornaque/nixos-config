{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-${system.stateVersion}";

    home-manager = {
      url = "github:nix-community/home-manager/release-${system.stateVersion}";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {
    # Available through 'nixos-rebuild --flake .#main'
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/flake.nix#L21
      system = "x86_64-linux";
      module = [ ./configuration.nix ];
    };

    # Available through 'home-manager --flake .#user'
    homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
      # Home-manager requires 'pkgs' instance
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./home.nix ];
    }
  };
}