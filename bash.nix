
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
      GOPATH = "/Users/lekva/dev/go";
      GOBIN = "/Users/lekva/dev/go/bin";
      KUBE_EDITOR = "emacs -nw";
      AWS_PROFILE = "deepchannel-infra";
    };
    initExtra = ''
      ssh-add ~/.ssh/id_rsa_github
      ssh-add ~/.ssh/id_rsa_freeuni
      . ~/dev/src/deepchannel/infrastructure/tools/aws-helper-functions
    '';
  };
}
