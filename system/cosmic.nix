{pkgs, ... }: {
  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-term
    cosmic-store
  ];
}
