{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName  = "Enda";
    userEmail = "gavenda@disroot.org";
    extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        user.signingkey = "423ED7E7BC85C45D";
    };
  };
}
