
{ config, pkgs, ... }:

let
vars = import ./vars.nix;
inherit (vars) USERNAME HOSTNAME TIMEZONE;
in

{
  home.username = USERNAME;
  home.homeDirectory = "/home/${USERNAME}";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/nvim/";
    "kitty".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/kitty/";
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/hypr/";
    "ohmyposh.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/ohmyposh.toml";
    "tmux".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/tmux/";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/fastfetch/";
    "cava".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/cava/";
    "quickshell".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/quickshell/";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/btop/";
    "nushell".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/nushell/";
    "uwsm".source = config.lib.file.mkOutOfStoreSymlink "/home/${USERNAME}/dotfiles/uwsm/";

  };
  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [

  ];

}
