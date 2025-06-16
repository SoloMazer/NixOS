{
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
}
