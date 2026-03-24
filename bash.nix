
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
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    '';
    shellAliases = {
      go = "go1.18";
      ".." = "cd ..";
      bz = "bazelisk";
      bzb = "bazelisk build";
      bzr = "bazelisk run";
      bazel = "bazelisk";
      e = "emacs -nw";
      g = "git";
      ga = "git add";
      gc = "git commit -m";
      gd = "git diff";
      gp = "git push";
      gpo = "git push og";
      gpom = "git push og main";
      gs = "git status";
      hm = "home-manager";
      hmb = "home-manager build";
      hms = "home-manager switch";
      k = "kubectl";
      kl = "kill %";
      ll = "ls -l";
    };
    sessionVariables = {
      EDITOR = "emacsclient -n";
      ALTERNATE_EDITOR = "";
      NODE_OPTIONS = "--max-old-space-size=8192";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
    initExtra = ''
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

      PS1='\w \$ '
    '';
  };
}
