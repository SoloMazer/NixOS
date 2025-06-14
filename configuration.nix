{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-ff42987a-cfcc-4861-b70a-e80735efba68".device = "/dev/disk/by-uuid/ff42987a-cfcc-4861-b70a-e80735efba68";
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

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

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-photos
    gnome-contacts
    gnome-weather
    gnome-maps
    epiphany
    geary
    decibels
    snapshot
    gnome-characters
    file-roller
    gnome-font-viewer
    gnome-music
    totem
    simple-scan
    gnome-connections
    evince
    yelp
  ]);

  # Enabling Cosmic Desktop
  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-term
    cosmic-store
  ];

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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable Essential Programs
  programs.fish.enable = true;
  programs.git.enable = true;
  programs.nh.enable = true;

  # Enable experimental nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to be installed on the base system
  environment.systemPackages = with pkgs; [
    fzf
    librewolf
    ripgrep
    fd
    helix
  ];

  # Enable Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    randomizedDelaySec = "45min";
  };

  # Enable Automatic store Optimization
  nix.optimise = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    randomizedDelaySec = "45min";
  };

  # Enable autoUpgrade
  system.autoUpgrade = {
    enable = true;
    flake = "path:/home/solomazer/.config/nixos";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    dates = "weekly";
    operation = "boot";
    persistent = true;
    randomizedDelaySec = "45min";
    fixedRandomDelay = true;
    allowReboot = false;
  };

  system.stateVersion = "25.11";
}
