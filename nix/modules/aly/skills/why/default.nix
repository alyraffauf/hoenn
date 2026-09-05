_: let
  skillSource = import ../_lib.nix ./.;
in {
  flake.homeModules.aly = {
    home.file.".agents/skills/why".source = skillSource;
    programs.codex.skills.why = skillSource;
    programs.opencode.skills.why = skillSource;
    programs.crush.skills.why = skillSource;
    programs.claude-code.skills.why = skillSource;
  };
}
