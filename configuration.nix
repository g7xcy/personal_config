# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # nix.settings = {
  #   # given the users in this list the right to specify additional substituters via:
  #   #    1. `nixConfig.substituters` in `flake.nix`
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.kernel.sysctl = {
    "net.ipv6.conf.wlp4s0.accept_ra" = "2";
  };
  # Enable bluetooth
  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 3d";

  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org/" ];
networking = {
  hostName = "server";
    nameservers = [ "8.8.8.8" "8.8.4.4" "114.114.114.114"];
    # useNetworkd = true;
    # networkmanager.enable = true;
    wireless = {
      enable = true;
      networks = {
        "wifi ssid" = {
          psk = "wifi password";
        };
      };
    };
    interfaces.wlp4s0.ipv6 = {
      addresses = [
        {
          address = "static ipv6 address";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway6 = {
      address = "ipv6 gateway address";
      interface = "wlp4s0";
    };
  };
  # systemd.network.wait-online.enable = true;  # 启用 systemd 的网络等待服务
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # enable docker
  # virtualisation.docker.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://192.168.100.5:1234";
  # networking.proxy.default = "http://192.168.100.1:3128/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.inputMethod = {
  #   enabled = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [
  #     libpinyin
  #     rime
  #   ];
  # };
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable critical components.
  # security.polkit.enable = true;
  # services.xserver.enable = true;
  # Choose one of the display manager for login.
  # services.xserver.displayManager.defaultSession = "plasma";

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.windowManager.i3.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Remote Desktop
  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "startplasma-x11";
  # services.xrdp.openFirewall = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.frederica = {
    isNormalUser = true;
    description = "Frederica the Malzeno!";
    home = "/home/frederica";
    extraGroups = [ "wheel" "networkmanager" "video" "tty" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "pub key"""
    ];
  };
  users.users.server = {
    isNormalUser = true;
    description = "mc server";
    home = "/home/server";
    extraGroups = [ "tty" ];
    openssh.authorizedKeys.keys = [
      "pub key"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    busybox
    curl
    direnv
    fish
    fzf
    git
    helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    htop
    iw
    zulu21
    neofetch
    nmap
    screen
    usbutils
    unzip
    wget
    zip
    zoxide
  ];
  
  # set default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.variables.EDITOR = "hx";
  environment.variables.BROWSER = "elinks";
  environment.variables.COLORTERM = "truecolor";
  environment.variables.fish_charset = "utf-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking = {
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 16384 25565 ];
      allowedUDPPorts = [ 4242 ];
      extraCommands = ''
        ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
        ip6tables -A INPUT -p tcp --dport 16384 -j ACCEPT
        ip6tables -A INPUT -p tcp --dport 25565 -j ACCEPT
      '';

      # allowedTCPPortRanges = [
      #   {from = 21114; to = 21119;}
      # ];
      # allowedUDPPortRanges = [
      #   {from = 1714; to = 1764;}
      # ];
    };
  };

  # Enabla SSH
  services.openssh = {
    enable = true;
    ports = [ 16384 ];
    settings = {
      AllowTcpForwarding = "yes";
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
    };
    openFirewall = true;
    allowSFTP = true;
  };
  
  # Enable nebula
  services.nebula.networks.n100 = {
    enable = true;
    isLighthouse = false;
    cert = "/etc/nebula/host.crt";
    key = "/etc/nebula/host.key";
    ca = "/etc/nebula/ca.crt";
    
    staticHostMap = {
      "192.168.100.1" = [ "nebula lighthouse ip" ];
    };
    lighthouses = ["192.168.100.1"];

    isRelay = false;
    relays = ["192.168.100.1"];
    
    listen.host = "::";
    listen.port = 4242;

    firewall.outbound = [ { port = "any"; proto = "any"; host = "any"; } ];
    firewall.inbound = [ { port = "any"; proto = "tcp"; host = "any"; } ];
  };
  
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

