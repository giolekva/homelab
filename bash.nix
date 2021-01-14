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
      e = "emacs -nw";
      enw = "emacs -nw";
      g = "git";
      ga = "git add";
      gc = "git commit -m";
      gd = "git diff";
      gp = "git push";
      gs = "git status";
      hm = "home-manager";
      k = "kubectl";
      ll = "ls -l";
    };
  };
}
