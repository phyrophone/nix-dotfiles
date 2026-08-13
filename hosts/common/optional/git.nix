{ ... }: {
  programs.git = {
    enable = true;
    config = [
      {
        init.defaultBranch = "main";
        user = {
          email = "255566614+phyrophone@users.noreply.github.com";
          name = "phyrophone";
        };
      }
    ];
  };
}
