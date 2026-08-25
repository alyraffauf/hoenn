_: let
  skillSource = import ../_lib.nix ./.;
in {
  flake.homeModules.aly = {
    home.file.".agents/skills/code-qa".source = skillSource;
    programs.codex.skills."code-qa" = skillSource;
    programs.opencode.skills."code-qa" = skillSource;
    programs.crush.skills."code-qa" = skillSource;
    programs.claude-code.skills."code-qa" = skillSource;
  };
}
