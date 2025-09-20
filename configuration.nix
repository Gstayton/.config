# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/nvidia.nix
  ];

  nixpkgs.config.allowUnfree = true;

  #fileSystems = {
  #  "/".options = [ "compress=zstd" ];
  #  "/home".options = [ "compress=zstd" ];
  #  "/nix".options = [ "compress=zstd" "noatime" ];
  #  #"/swap".options = [ "noatime" ];
  #  "/var".options = [ "compress=zstd" ];
  #};

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Omnius"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.hosts = {
    "192.168.0.235" = [ "tokyo" ];
	"192.168.0.5" = [ "pihole" ];
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  # font = "Lat2-Terminus16";
  # keyMap = "us";
  # useXkbConfig = true; # use xkb.options in tty.
  #};

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # System will be using hyprland & wayland - no x11

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pulseaudio.enable = false;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  #Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kosan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "kosan"
  ];

  programs.firefox.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.waybar.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.steam.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    wayland-utils
    xdg-desktop-portal-hyprland
    kdePackages.sddm-kcm
    kitty
    wofi
    x11_ssh_askpass
    git
    python3
    luajitPackages.luarocks-nix # maybe not needed anymore without mason?
    lua51Packages.lua
    p7zip
    cliphist
    wl-clipboard
    discord
    (flameshot.override { enableWlrSupport = true; }) # screenshot utility
    neofetch
    mpc # cli music player
    ymuse # mpc client
    rmpc # tui mpc client
    unzip
    tmux
    cargo
    gcc_multi
    lua-language-server # required for nvim completion
    nil # another nvim lsp
    nodejs_20 # orignally for mason - probably not needed anymore
    lazygit # has tmux bindings
    ripgrep
    fzf
    ranger
    keychain
    qpwgraph # pipewire gui
    teamspeak3
    pavucontrol # volume control - because nothing else was working
    cifs-utils
    nixfmt-rfc-style # used for nvim nix formatting
    devenv # fucking mess
    direnv # Previously for devenv, may be good for venv still
    hypridle # dpms control
    starship # terminal prompt customization
    bitwarden-desktop # password management
    bitwarden-cli # see above, but cli
    #rofi-rbw-wayland
	mpv
	obs-studio
	obs-cli
  ];

  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      }
    ))
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  #services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "${config.users.users.kosan.home}/Music/";
    network.listenAddress = "any";
    #network.startWhenNeeded = true;
    extraConfig = ''
            audio_output {
              type "pipewire"
      	name "MPD Output"
            }
    '';
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
