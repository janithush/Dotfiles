{ config, pkgs, herdr, ... }:

let
 dotfiles = "${config.home.homeDirectory}/files"; 
in

# 1\. User Info
 { home.username = "janithx";
 home.homeDirectory = "/home/janithx";
 home.stateVersion = "24.11";

# 2\. Symlink Neovim Configuration Directory 
home.file.".config/nvim".source =
 config.lib.file.mkOutOfStoreSymlink 
"${config.home.homeDirectory}/files/home/.config/nvim";

home.file.".config/herdr".source =
 config.lib.file.mkOutOfStoreSymlink
 "${dotfiles}/home/.config/herdr";

 home.file.".claude/settings.json".source =
 config.lib.file.mkOutOfStoreSymlink
 "${dotfiles}/home/.claude/settings.json";

 home.file.".config/wezterm".source =
 config.lib.file.mkOutOfStoreSymlink
 "${dotfiles}/home/.config/wezterm";



 # 1\. Packages (Neovim + Kun's essential CLI tools)
 home.packages = with pkgs; [
 git
 ripgrep
 fd
 htop
 neovim
 herdr.packages.${pkgs.system}.default
 ];

# 4. Environment Varialbes
home.sessionVariables = {
 EDITOR = "nvim";
 };

# 5\. Zsh Shell Configurations
programs.zsh = {
 enable = true;
autosuggestion.enable = true; # ghost text from history
syntaxHighlighting.enable = true; # commands turn green when valid
initExtra = ''
bindkey '^f' autosuggest-accept 
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

# 6\. Starship Prompt Setup
programs.starship = {
 enable = true;
 enableZshIntegration = true;
 settings = {
 add_newline = false;
 format =
 "$directory$git_branch$git_status$cmd_duration$line_break$character";
 character = {
 success_symbol = "[❯](purple)";
 error_symbol = "[❯](red)";
 };
 cmd_duration.format = "[$duration]($style) ";
 };
};

programs.git = {
 enable = true;
 settings = {
 user = {
 name = "janithush";
 email = "janith.ushanthaapple@gmail.com";
 };
};
};

# 7\. Enable Home Manager
programs.home-manager.enable = true;
}
