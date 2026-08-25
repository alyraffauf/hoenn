_: let
  skillSource = import ../_lib.nix ./.;
in {
  flake.homeModules.aly = {
    home.file.".agents/skills/quality-code".source = skillSource;
    programs.codex.skills."quality-code" = skillSource;
    programs.opencode.skills."quality-code" = skillSource;
    programs.crush.skills."quality-code" = skillSource;
    programs.claude-code.skills."quality-code" = skillSource;
  };
}
