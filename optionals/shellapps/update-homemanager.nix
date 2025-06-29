{
  writeShellApplication,
  home-manager,
  nix,
}:
writeShellApplication {
  name = "update-homemanager";
  runtimeInputs = [
    home-manager
    nix
  ];
  text = ''
    nix flake update ~/.config/home-manager/flake.nix && home-manager switch --flake ~/.config/home-manager/flake.nix
  '';
}
