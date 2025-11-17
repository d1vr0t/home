{
  pkgs,
  lib,
  wckavim,
  ...
}:
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };
  home = {
    username = "wcka";
    homeDirectory = "/home/wcka";
    packages =
      with pkgs;
      [
        tldr
        vesktop # Fuck discord
        thunderbird # Mail
        unzip
        spotify # Musik
        nix-output-monitor # Nom nom nom
        nixd # Nix Sprachserver
        xsane # Scanner
        gimp # Grafikbearbeitung
        wine # Windows Comp
        vscode # IDE
        imagemagick
        pavucontrol # Audio gain controls
        manix # Nix fuzzy search
        firefox
        tor-browser
	audacity
	ffmpeg
      ]
      ++ [ wckavim ]
      ++ builtins.attrValues (
        lib.filesystem.packagesFromDirectoryRecursive {
          callPackage = pkgs.callPackage;
          directory = ./optionals/shellapps;
        } # All Shellapps in this directory
      );
  };

  programs = {
    git = {
      enable = true;
      userName = "Alexander Weck";
      userEmail = "accounts@awck.de";
      extraConfig = {
        safe.directory = "/etc/nixos";
        core.editor = "nvim";
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        character = {
          success_symbol = "[›](bold green)";
          error_symbol = "[›](bold red)";
        };

        git_status = {
          deleted = "✗";
          modified = "✶";
          staged = "✓";
          stashed = "≡";
        };
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableVteIntegration = true;
      history.append = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "n" = "nvim";
        "vi" = "nvim";
        "nconf" = "sudo nvim /etc/nixos/configuration.nix";
      };
    };

    home-manager.enable = true;
  };
  services = {
    podman = {
      enable = true;
      containers = {
        excalidraw = {
          image = "excalidraw/excalidraw:latest";
          autoStart = true;
          ports = [
            "127.0.0.1:1602:80"
          ];
          environment.TZ = "Europe/Berlin";
        };

      };
    };

  };

  systemd.user.services = {
    auto-document-upload = {
      Unit = {
        Description = "Uploads scanned documents to paperless";
      };

      Service = {
        ExecStart = "${pkgs.callPackage ./scripts/auto-upload-scanned-docs.nix { }}/bin/auto-upload-scans";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

  home.stateVersion = "24.11";
}
