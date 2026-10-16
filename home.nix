{ config, pkgs, herdr, no-mistakes, treehouse, ... }:

let
  dotfiles = "${config.home.homeDirectory}/files";
  npmGlobal = "${config.home.homeDirectory}/.npm-global";
  # Linux-native AXI CLIs via pinned npx wrappers (zero Windows dependency).
  # Upstream recommends zero-setup `npx -y <pkg>`; wrappers pin versions for reproducibility.
  axiNpx = pkg: ver: pkgs.writeShellScriptBin pkg ''
    exec ${pkgs.nodejs}/bin/npx -y ${pkg}@${ver} "$@"
  '';
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
  home.file.".config/opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/opencode/opencode.jsonc";
  home.file.".config/opencode/orchestration-rules.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/opencode/orchestration-rules.json";


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
    # Trusted Flakes (Go, Nix-native)
    no-mistakes.packages.${pkgs.system}.default
    treehouse.packages.${pkgs.system}.default
    # Trusted npm AXI tools, Linux-native via pinned npx wrappers (no /mnt/c dependency)
    # quota-axi is the canonical name (replaces earlier quokka-axi reference)
    (axiNpx "gh-axi" "0.1.36")
    (axiNpx "chrome-devtools-axi" "0.1.39")
    (axiNpx "lavish-axi" "0.1.85")
    (axiNpx "quota-axi" "0.1.60")
    (axiNpx "gnhf" "0.1.51")
    # Lab tools (mobbin-axi, chezmoi-axi, design-system-axi, playwright-axi) stay in ~/lab/, NOT here
  ];

  # Linux-native npm global prefix (Nix store nodejs root is read-only).
  # Keeps `*-axi setup hooks` global installs inside WSL ext4, never Windows npm.
  home.file.".npmrc".text = "prefix=${npmGlobal}\n";
  home.sessionPath = [ "${npmGlobal}/bin" ];

  # Environment Variables
  home.sessionVariables = {
    EDITOR = "nvim";
    # OmniRoute local gateway (2026-10-10): all harnesses route via WSL2 gateway
    ANTHROPIC_BASE_URL = "http://localhost:20128";
    # Secret - kept as local override, NOT committed (see bashrc + per-panel exports):
    # ANTHROPIC_AUTH_TOKEN = "<Endpoint key from dashboard>";
    ANTHROPIC_MODEL = "stage1-code-gen";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "stage1-code-gen";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "stage1-code-gen";
    # Security: OmniRoute gateway enforces REQUIRE_API_KEY=true (server-side in ~/.omniroute/.env).
    # Harnesses must send ANTHROPIC_AUTH_TOKEN on every request.
    REQUIRE_API_KEY = "true";
    ANTHROPIC_API_KEY = "sk-omniroute";
    CLAUDE_CODE_DISABLE_UNKNOWN_MODEL_WINDOW_ENFORCEMENT = "1";
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
