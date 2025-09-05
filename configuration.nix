
{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		/etc/nixos/hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelModules = [ "rtw89" ];
	networking.hostName = "Paradox";
	networking.networkmanager.enable = true;
	networking.networkmanager.wifi.backend = "iwd";
	time.timeZone = "Asia/Kolkata";
	i18n.defaultLocale = "en_IN";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.wayland.enable = true;

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’!!!
	users.users.volty = {
		isNormalUser = true;
		description = "volty";
		extraGroups = [ "networkmanager" "wheel" ];
	};

# Install applications
	programs.firefox.enable = true;
	programs.hyprland.enable = true;
	programs.fish.enable = true;
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		kitty
		neovim
		brightnessctl
		wget
		curl
		git
	];
	users.defaultUserShell = pkgs.fish;

	hardware.enableAllFirmware = true;

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




system.stateVersion = "25.05";
}
