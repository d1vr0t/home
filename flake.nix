{
  description = "Home Manager configuration of wcka";

  inputs = {
    editor.url = "github:d1vr0t/wckavim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      editor,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      wckavim = editor.packages.${system}.wckavim;
    in
    {
      homeConfigurations."wcka" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit wckavim;
        };
      };

      files.homeConfig = ./home.nix;

    };
}
