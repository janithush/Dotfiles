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

programs.home-manager.enable = true;
}
