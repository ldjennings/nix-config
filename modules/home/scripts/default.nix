{
  pkgs,
  ...
}: {
  home.packages = [
    (import ./squirtle.nix {inherit pkgs;})
    (import ./hm-find.nix {inherit pkgs;})
  ];
}