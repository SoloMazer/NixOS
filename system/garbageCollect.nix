{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    randomizedDelaySec = "45min";
  };
}
