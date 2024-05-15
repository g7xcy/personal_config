# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "<username>";

  # enable flakse
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # set timezone
  time.timeZone = "Asia/Shanghai";
  
  # setting sudo rules
  # security.sudo.keetTerminfo = true;

  # add system packages
  environment.systemPackages = with pkgs; [
    curl
    direnv
    fish
    fzf
    git
    helix
    neofetch
    nil
    nixfmt
    ollama
    pyright
    python311
    ruff
    ruff-lsp
    wget
    zoxide
  ];

  # set environment variables
  environment.variables.EDITOR = "hx";
  environment.variables.COLORTERM = "truecolor";
  environment.variables.fish_charset = "utf-8";

  # enable fish shell
  programs.fish.enable = true;
  # set default shell to fish
  users.defaultUserShell = pkgs.fish;

  # add user
  users.users.<username> = {
    isNormalUser = true;
    home = "/home/<username>";
    description = "";
    extraGroups = [ "wheel" ];
  };

  # change firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
  };

  # enable ssh
  services.openssh = {
    enable = true;
    settings = {
      port = <port>;
      X11Forwarding = true;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      PasswordAuthentication = true;
    };
    openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment<port>
