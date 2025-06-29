{ writeShellApplication, nix }:
writeShellApplication {
  name = "repl";
  runtimeInputs = [ nix ];
  text = ''
    nix repl --file '<nixpkgs>'
  '';
}
