_: let
  skillSource = import ../_lib.nix ./.;
in {
  flake.homeModules.aly = {
    home.file.".agents/skills/how".source = skillSource;
    programs.codex.skills.how = skillSource;
    programs.opencode.skills.how = skillSource;
    programs.crush.skills.how = skillSource;
    programs.claude-code.skills.how = skillSource;
  };
}
