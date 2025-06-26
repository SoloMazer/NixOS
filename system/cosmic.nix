{pkgs, ...}: {
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;
  services.displayManager.cosmic-greeter.enable = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-term
    cosmic-store
  ];
}
