{ pkgs, ... }:
let
  fhs = pkgs.buildFHSUserEnvBubblewrap {
    name = "nerves-buildroot-fhs";
    targetPkgs = pkgs: ( with pkgs; [
      #elixir stuff
      autoconf
      automake
      curl
      elixir
      erlang
      fwup
      gnumake
      inotify-tools
      libnotify
      pkg-config
      rebar3
      sqlite
      squashfsTools
      x11_ssh_askpass

      #buildroot stuff
      #https://buildroot.org/downloads/manual/manual.html#requirement-mandatory
      bc
      binutils
      bzip2
      cpio
      file
      gcc
      glibc_multi
      gnumake
      gzip
      ncurses5
      patch
      perl
      rsync
      unzip
      util-linux #for sed, tar
      wget
      which

      #https://buildroot.org/downloads/manual/manual.html#requirement-optional
      python
      kconfig-frontends
      git
    ]);
    multiPkgs = (pkgs: with pkgs; [ glibc_multi] );
    extraOutputsToInstall = [ "dev" ];
    profile = ''
      export C_INCLUDE_PATH=/usr/include:$C_INCLUDE_PATH
      export CC=${pkgs.gcc}/bin/gcc
      export CXX=${pkgs.gcc}/bin/g++
      export LC_LOCALE=c
    '';
  };
in
  fhs.env
