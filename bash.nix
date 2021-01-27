{
  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyFileSize = 10000000;
    historySize = 10000;
    profileExtra = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
      ".." = "cd ..";
      bz = "bazelisk";
      bzb = "bazelisk build";
      bzr = "bazelisk run";
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
      hmb = "home-manager build";
      hms = "home-manager switch";
      k = "kubectl";
      kl = "kill %";
      ll = "ls -l";
    };
  };
}
