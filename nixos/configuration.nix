
{ config, pkgs, lib, ... }:

let
vars = import ./vars.nix;
inherit (vars) USERNAME HOSTNAME TIMEZONE;
in

{
  imports =
    [
    ./hardware-configuration.nix
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
      "ehci_pci"
      "uhci_hcd"
      "usb_storage"
      "sd_mod"
      "ahci"
      "nvme"
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "rtw89" ];
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  networking.hostName = HOSTNAME;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.wifi.scanRandMacAddress = false;
  networking.networkmanager.wifi.backend = "iwd";
  time.timeZone = TIMEZONE;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.gvfs.enable = true;
  security.sudo.extraConfig = ''
    Defaults insults
    '';

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

# Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pulseaudio.package = pkgs.pulseaudioFull;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;
  services.blueman.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’!!!
  users.users.${USERNAME} = {
    isNormalUser = true;
    description = "${USERNAME}";
    extraGroups = [ "networkmanager" "wheel" "input" "keyd" "i2c" ];
    shell = pkgs.nushell;
    maid = {
      file.xdg_config."hypr/".source = "{{home}}/dotfiles/hypr/";
      file.xdg_config."btop/".source = "{{home}}/dotfiles/btop/";
      file.xdg_config."cava/".source = "{{home}}/dotfiles/cava/";
      file.xdg_config."fastfetch/".source = "{{home}}/dotfiles/fastfetch/";
      file.xdg_config."kitty/".source = "{{home}}/dotfiles/kitty/";
      file.xdg_config."nushell/".source = "{{home}}/dotfiles/nushell/";
      file.xdg_config."nvim/".source = "{{home}}/dotfiles/nvim/";
      file.xdg_config."quickshell/".source = "{{home}}/dotfiles/quickshell/";
      file.xdg_config."tmux/".source = "{{home}}/dotfiles/tmux/";
      file.xdg_config."uwsm/".source = "{{home}}/dotfiles/uwsm/";
      file.xdg_config."ohmyposh.toml".source = "{{home}}/dotfiles/ohmyposh.toml";
      file.xdg_config."yazi/".source = "{{home}}/dotfiles/yazi/";

      dconf.settings = {
        "/org/gnome/desktop/interface/gtk-theme" = "rose-pine-dawn";
        "/org/gnome/desktop/interface/font-name" = "Ubuntu Nerd Font Regular 11";
        "/org/gnome/desktop/interface/color-scheme" = "prefer-dark";
        "/org/gnome/desktop/interface/font-hinting" = "full";
        "/org/gnome/desktop/interface/font-antialiasing" = "rgba";
        "/org/gnome/desktop/interface/cursor-theme" = "'Kokomi_Cursor'";
        "/org/gnome/desktop/interface/cursor-size" = 24;
      };

    };
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    extra-substituters = [ "https://yazi.cachix.org" ];
    extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
  };

# Install applications
  programs.yazi.enable = true;
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    (callPackage ./pokego.nix{})
      (callPackage ./kokoCursor.nix{})
      bash
      brightnessctl
      btop
      cava
      clang
      cliphist
      cmake
      curl
      fastfetch
      gcc
      git
      glib
      glibc
      grimblast
      gzip
      hyprlang
      hyprpicker
      kitty
      libnotify
      lua-language-server
      man
      mesa
      neovim
      nil
      nixpkgs-fmt
      nushell
      oh-my-posh
      power-profiles-daemon
      ripgrep
      rose-pine-gtk-theme
      tmux
      tree-sitter-grammars.tree-sitter-hyprlang
      unzip
      upower
      upower-notify
      vimPlugins.nvim-treesitter-parsers.hyprlang
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      wget
      yank
      zip
      quickshell
      nautilus
      adwaita-icon-theme
      ];

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;
  hardware.i2c.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    intel-media-driver
  ];

#fonts
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
      nerd-fonts.ubuntu
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
  ];

#bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
        Enable = "Source,Sink,Media,Socket";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

#keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  system.stateVersion = "25.05";
}
