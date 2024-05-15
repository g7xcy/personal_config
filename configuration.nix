# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 3d";

  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix/channels/store" ];
  # networking = {
  #   hostName = "Frederica"; # Define your hostname.
  #   interfaces.eth0.useDHCP = true;
  #   nameservers = [ "8.8.8.8" "4.4.3.4" ];
  # };
  networking.hostName = "FredericaN100";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # enable docker
  virtualisation.docker.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable Xrdp service
  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "icewm";
  # services.xrdp.openFirewall = true;


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.frederica = {
    isNormalUser = true;
    description = "Frederica the Malzeno!";
    home = "/home/frederica";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzacmNpTR9sV0w9dsrYZ9frwmOnkfaHJwcsU0SUo4xB+VWwZsPnQnMxzvrtlaP/PvPxeggwOM+XAbZTuOS9A4PP/Bt9zZt4gvPymK70+BpZMc+AXdiEGgSJkoNI5cFuhbhlb6b8tJUuWOXOqyMHP22gn8M94dBvYStkjT8Ugoa2wYzwYc9kTBlQ/ika2Lhmbo8wkSI2d+GLSmbujDqMcc49kSEsceHhPpM00LIX6vuuZbFONBZ9jEMlSxZaZK8ksJuM7ofY8z1+u3HKUBKpHohgctjp436Q1v2bFF0q9HfzT0O90HLefFJjuJN5teosYGz8CqnAxAy7BrSlV+6qP8rzGZBe1FU598ElToP6ZnKeMqG8g0ayKdWA3q+VMVoHLZZ802ks8wrZXUXvo8P9cJs5kzPx8/UM0NqlRKZjzbBURL3swHdU4X5X7nERN7FG6x/5tlvBc2WJH2sTC8wXdSDFj3OtXlSPLskS18XxwJ4PKBbrJNqkXBJFZsJdSknI87aIi5qKU+g+xxoqg1rVH+VNa1oRRqjtAaGFs/nwZD/8fAHuBjjdVRHCKv1Q2yMvTojVIk/hs2Nh9W7BAx8y99QRpd/Atf3K+z6zSXGYtkaRoPfm0zTEFwUKZL3ff7PQzqAuZGAL5TBcKIb7xafLuoo/tvwvHwD0WYWZMq+6OmTww== g7xcy@Frederica"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCW78dW6tQKkJDWeZ872D29ZcFjpJp/L9dBUeU1MQLgrqbJULiTO0rKig1inTO6x29eCjhainOTLdvjXFI8l3AxZ9LbhNfioZ8mz1rYj2lYmwvlYH123P7FTWq2PwSrVo+4Y6OHuWQ8221UVWQ/EZswUYFgHPz1hQkjZR7t6OyWfs0KWZHwN/+/3uSS9ag589aiKtOSF7aTd2ggfE2qAcyBbGrWDVkB1lJIDJ648s0VxpbL3l6lVBwwUJVKU3CywumaMO42vEm5OxcPLUIrCM5LN+2RGxoNB8v5o8SGbhTd2kuhS2fCTHDMg8TUh8ZWygrDDTrSBNHg0GfzZDx9kKszKeAHZyTozBAh1z2Durhoxf1vwRblpz6KJ0e5qZAZZZKno6IF6T354S/siCDTY4vUIATd0fp9u50/kOwCGyPcArZWAoS3rzkAnPDWdKR0dIVLt36HIvH+tTmIx0dBABzytmViuFfk0YNEVyw9jrGroya1lqzL+u2s7U7cRF+Mp6+9CSOiQ66b1GB5D3/NjAT0j9sMy1dEv5yABaYNSlq0N6H7uaFHIN7XObbE7JGDSaH2+7VsduFw7w8498xL7ROTk+o2iiQWsuszD7jSgLGaCGAm4T20bMstIRltO3XEka2T+WQtdrIVYYpe4NNp87++rVhgooaIJE8gT7tOVNZg7w== u0_a120@localhost"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxwTm7pOA85w+Id8setx5d4yKoXjv0fRQ8pczvjnz8gBTyytxE5nu1i81yc+p7WcJ+o+94yd0aBDFDoW6QNwuU6fT7XbDb9aaeMolnNmxEzOAMbvIaMt3lI2qTfs5FKmFWv0dcmQZ79ggPfANnaJGX57o0+DOZ7muZXWXhkEkIyn8gP+0guKpSrP1ovSiwX23SqXF7PI/qsVV/LtqrJBpU2ouqRCZNQPgn4+hd5/Nfg7zPuuDJl9kjsqQKBLxPRBRvmwcpuS6vxzZFh9Ix3cYN3EL8BgFjGsShSbLyXYkcML+P9IjEC47zlctjLesM7ShyyGf+pnsqgzmHoP5ebFuozbTu1CBsLD2EaQvv+cHYuxQVm6/SZfPNdVGjA2qrh4KAUYGvXvukEQnBvDQNFsPSzOaUVXCoSFN9hUGBQVbHUkr3DkghfZKYSetnSfsJHFwepZW39HCgcS4dWR6GX5lIuZxqchw1hMrG+dnfCOGHV4yHM9h55i1Uugu0EI1uRfr4cEnVmTuOZSMWTN284WTx+hJZjhRyCqOJSUWOjvkM9BeZ//h+YzGDzCsLFPdTXzB6tXQYphPBkOscnem9QKZKG/Kjppihf78sx9qsk0FXJ4M7QhGU84SDx0ffpIul8NEyz88utyCxCkzforSCLsy3AVesdlMeYQGrZ9JwH/wbZw== frederica@VPS"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    direnv
    # elinks
    firefox
    fish
    fzf
    git
    helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    nebula
    neofetch
    screen
    w3m
    wget
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
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 16384 25565 ];
    allowedUDPPorts = [ 4242 ];
  };

  # Enabla SSH
  services.openssh = {
    enable = true;
    ports = [ 16384 ];
    settings = {
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
    };
    # openFirewall = true;
  };
  
  # Enable nebula
  services.nebula.networks.n100 = {
    enable = true;
    isLighthouse = false;
    cert = "/etc/nebula/host.crt";
    key = "/etc/nebula/host.key";
    ca = "/etc/nebula/ca.crt";
    staticHostMap = {
      "192.168.100.1" = [ "frederica.top:4242" ];
      "192.168.100.2" = [ "1.94.10.179:4242" ];
    };
    lighthouses = [ "192.168.100.1" "192.168.100.2" ];
    listen.host = "::";
    listen.port = 0;
    firewall.outbound = [ { port = "any"; proto = "any"; host = "any"; } ];
    firewall.inbound = [ { port = "any"; proto = "any"; host = "any"; } ];
  };
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
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

