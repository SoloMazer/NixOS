{ pkgs, ... }: {
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
}
