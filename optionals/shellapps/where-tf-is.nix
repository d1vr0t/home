{ writeShellApplication }:
writeShellApplication {
  name = "where-tf-is";
  runtimeInputs = [ ];
  text = ''
    dirname "$(readlink -f "$(which "$@")")"
  '';
}
