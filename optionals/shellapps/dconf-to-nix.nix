{
  writeShellApplication,
  dconf,
  dconf2nix,
}:
writeShellApplication {
# Exports the current dconf to a nix expression
  name = "dconf-to-nix";
  runtimeInputs = [
    dconf
    dconf2nix
  ];
  text = ''
    dconf dump / | dconf2nix > gnome-dconf.nix
  '';
}
