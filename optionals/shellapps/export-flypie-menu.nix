{
  writeShellApplication,
  dconf,
}:
writeShellApplication {
  name = "export-flypie-menu";
  runtimeInputs = [
    dconf
  ];
  text = ''
    dconf read /org/gnome/shell/extensions/flypie/menu-configuration > flypie-menu.json 
  '';
}
