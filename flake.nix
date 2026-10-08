{ description = "My Windows WSL2 Reproducible Environment";

 inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
 home-manager = { url = "github:nix-community/home-manager";
 inputs.nixpkgs.follows = "nixpkgs";
 };


herdr = {
 url = "github:herdrdev/herdr";
 inputs.nixpkgs.follows = "nixpkgs";
 };
};

 outputs = {self, nixpkgs, home-manager, herdr, ... }:

   let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
	 in{



  homeConfigurations."janithx" = home-manager.lib.homeManagerConfiguration { 
inherit pkgs;
 modules = [ ./home.nix ];
extraSpecialArgs = { inherit herdr; };
 };
 };
 }

