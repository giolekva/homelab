{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    profileExtra = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
      ".." = "cd ..";
      bz = "bazelisk";
      bazel = "bazelisk";
      enw = "emacs -nw";
      g = "git";
      hm = "home-manager";
      k = "kubectl";
      ll = "ls -l";
    };
  };
}
