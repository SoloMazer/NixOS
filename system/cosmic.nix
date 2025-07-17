{pkgs, ...}: {
  specialisation.cosmic.configuration = {
    services.desktopManager.cosmic.enable = true;
    services.desktopManager.cosmic.xwayland.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-player
      cosmic-term
      cosmic-store
    ];
  };
}
