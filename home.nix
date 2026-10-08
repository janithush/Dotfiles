{ config, pkgs, herdr, ... }:

let
  dotfiles = "${config.home.homeDirectory}/files";
in
{
  home.username = "janithx";
  home.homeDirectory = "/home/janithx";
  home.stateVersion = "24.11";

  # Symlinks (out-of-store)
  home.file.".config/herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr/config.toml";

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";

  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";

  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";

  # Packages - fully declarative CLI tools only
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    htop
    jq
    nodejs
    eza
    bat
    lazygit
    opencode
    claude-code
    herdr.packages.${pkgs.system}.default
  ];

  # Environment Variables
  home.sessionVariables = {
    EDITOR = "nvim";
    # OpenRouter / Omni Router API Proxy Routing for Claude, OpenCode & Codex Harnesses
    ANTHROPIC_BASE_URL = "https://openrouter.ai/api/v1";
    # OPENROUTER_API_KEY = "your-key-here"; # Placeholder for local environment override
  };

  # Declarative Programs & CLI Tools
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "janithush";
        email = "janith.ushanthaapple@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Zsh Shell Configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindkey '^f' autosuggest-accept
      eval "$(zoxide init zsh)"
    '';

    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

  # Starship Prompt Setup
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Enable Home Manager
  programs.home-manager.enable = true;
}
