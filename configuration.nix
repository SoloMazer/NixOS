{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./system/gnome.nix
    ./system/cosmic.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-ff42987a-cfcc-4861-b70a-e80735efba68".device = "/dev/disk/by-uuid/ff42987a-cfcc-4861-b70a-e80735efba68";
  networking.hostName = "voidheart"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.sensor.iio.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.solomazer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "SoloMazer";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Enable experimental nix command and flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to be installed on the base system
  environment.systemPackages = with pkgs; [
    fzf
    librewolf
    ripgrep
    fd
    helix
    zenity
    protonvpn-gui
  ];

  # Enable Essential Programs
  programs.fish.enable = true;
  programs.git.enable = true;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d";
    };
  };

  # Enable Essential services
  # services.cloudflare-warp.enable = true;

  # Setup environment variables
  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    NH_OS_FLAKE = "/home/solomazer/.config/nixos";
    NH_HOME_FLAKE = "/home/solomazer/.config/home-manager";
  };

  system.stateVersion = "25.11";
}
