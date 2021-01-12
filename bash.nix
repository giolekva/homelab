{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    profileExtra = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      bz = "bazelisk";
      enw = "emacs -nw";
    };
  };
}
