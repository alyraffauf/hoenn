{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: let
    gitLfs = lib.getExe pkgs.git-lfs;
  in {
    packages.git = inputs.nix-wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      package = pkgs.gitFull;

      prefixVar = [
        [
          "PATH"
          ":"
          (lib.makeBinPath [
            pkgs.delta
            pkgs.git-lfs
          ])
        ]
      ];

      settings = {
        color.ui = true;
        github.user = "alyraffauf";

        user = {
          email = "aly@aly.codes";
          name = "Aly Raffauf";
        };

        init.defaultBranch = "master";

        fetch = {
          prune = true;
          pruneTags = true;
        };

        pull.rebase = true;

        rebase = {
          autoStash = true;
          autoSquash = true;
          updateRefs = true;
        };

        push = {
          autoSetupRemote = true;
          followTags = true;
        };

        rerere = {
          enabled = true;
          autoupdate = true;
        };

        merge.conflictStyle = "zdiff3";

        diff = {
          algorithm = "histogram";
          colorMoved = "zebra";
        };

        status.showUntrackedFiles = "all";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        help.autocorrect = "prompt";

        credential = {
          helper = "libsecret";
          "https://knot1.tangled.sh".helper = [
            ""
            "!tg auth git-credential"
          ];
          "https://forgejo.narwhal-snapper.ts.net".username = "alyraffauf";
        };

        alias = {
          s = "status -sb";
          l = "log --oneline --graph --decorate";
          ll = "log --graph --format=format:'%C(auto)%h %s %C(dim)(%an, %ar)%Creset' --all";
          amend = "commit --amend --no-edit";
          undo = "reset --soft HEAD^";
          gone = "!git fetch --prune && git branch -vv | awk '/: gone]/{print $1}' | xargs -r git branch -d";
        };

        pager = {
          blame = "delta";
          diff = "delta";
          log = "delta";
          show = "delta";
        };

        interactive.diffFilter = "delta --color-only";

        filter.lfs = {
          clean = "${gitLfs} clean -- %f";
          process = "${gitLfs} filter-process";
          required = true;
          smudge = "${gitLfs} smudge -- %f";
        };
      };
    };
  };
}
