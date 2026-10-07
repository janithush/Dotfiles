{ pkgs, ... }:
 { home.username = "janithx";
 home.homeDirectory = "/home/janithx";
 home.stateVersion = "24.11";
 # 1\. Packages (Neovim + Kun's essential CLI tools)
 home.packages = with pkgs; [
 git
 ripgrep
 fd
 htop
 neovim
 ];

home.sessionVariables = {
 EDITOR = "nvim";
 };

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

programs.home-manager.enable = true;
}
