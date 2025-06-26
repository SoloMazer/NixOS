{
  system.autoUpgrade = {
    enable = true;
    flake = "path:/home/solomazer/.config/nixos#voidheart";
    flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
    dates = "weekly";
    operation = "boot";
    persistent = true;
    randomizedDelaySec = "45min";
    fixedRandomDelay = true;
    allowReboot = false;
  };
}
