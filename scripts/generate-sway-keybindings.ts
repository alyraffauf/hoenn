#!/usr/bin/env bun

import { resolve } from "node:path";

const repositoryRoot = resolve(import.meta.dir, "..");
const configPath = resolve(repositoryRoot, "nix/modules/sway/config");
const outputPath = resolve(repositoryRoot, "nix/modules/sway/README.md");
const checkOnly = Bun.argv.slice(2).includes("--check");

type Keybinding = {
  action: string;
  section: string;
  shortcut: string;
};

const actionLabels = new Map<string, string>([
  ["kill", "Close window"],
  ["fullscreen toggle", "Toggle fullscreen"],
  ["floating toggle", "Toggle floating"],
  ["focus mode_toggle", "Switch focus between floating and tiling"],
  ["layout toggle tabbed splith splitv", "Cycle the container layout"],
  ["shortcuts_inhibitor toggle", "Toggle keyboard shortcuts inhibit"],
  ["exit", "Exit Sway"],
]);

function escapeMarkdown(value: string): string {
  return value.replaceAll("|", "\\|");
}

function formatShortcut(shortcut: string): string {
  const keyLabels = new Map<string, string>([
    ["$mod", "Mod"],
    ["Mod1", "Alt"],
    ["Mod4", "Super"],
    ["button4", "Wheel Up"],
    ["button5", "Wheel Down"],
    ["minus", "Minus"],
    ["equal", "Equal"],
    ["space", "Space"],
  ]);

  return shortcut
    .split("+")
    .map(
      (key) =>
        keyLabels.get(key) ?? (/^[a-z]$/.test(key) ? key.toUpperCase() : key),
    )
    .join(" + ");
}

function formatWorkspaceDestination(
  destination: string,
  workspaceIndex: string | undefined,
): string {
  if (destination === "next") {
    return "next";
  }

  if (destination === "prev") {
    return "previous";
  }

  if (!workspaceIndex) {
    throw new Error(`Could not read workspace from ${destination}`);
  }

  return workspaceIndex;
}

function formatWorkspaceAction(action: string): string | undefined {
  const workspace = action.match(/^workspace (next|prev|\$workspace(\d+))$/);
  if (workspace) {
    const destination = formatWorkspaceDestination(workspace[1], workspace[2]);
    return `Focus workspace ${destination}`;
  }

  const move = action.match(
    /^move container to workspace (next|prev|\$workspace(\d+))$/,
  );
  if (!move) {
    return undefined;
  }

  const destination = formatWorkspaceDestination(move[1], move[2]);
  return `Move container to workspace ${destination}`;
}

function formatResizeAction(action: string): string | undefined {
  const resize = action.match(
    /^resize (set|shrink|grow) (width|height) (\d+) ppt$/,
  );
  if (!resize) {
    return undefined;
  }

  const [, operation, dimension, percentage] = resize;
  if (operation === "set") {
    return `Set ${dimension} to ${percentage}%`;
  }

  const verb = operation === "grow" ? "Grow" : "Shrink";
  return `${verb} ${dimension} by ${percentage}%`;
}

function formatAction(action: string): string {
  if (action.startsWith("exec ")) {
    return `Run \`${action.slice("exec ".length)}\``;
  }

  const workspaceAction = formatWorkspaceAction(action);
  if (workspaceAction) {
    return workspaceAction;
  }

  const resizeAction = formatResizeAction(action);
  if (resizeAction) {
    return resizeAction;
  }

  const label = actionLabels.get(action);
  if (label) {
    return label;
  }

  const normalizedAction = action.replaceAll("_", " ");
  return `${normalizedAction.charAt(0).toUpperCase()}${normalizedAction.slice(1)}`;
}

function renderTable(keybindings: Keybinding[]): string {
  const rows = [
    ["Shortcut", "Action"],
    ...keybindings.map((keybinding) => [
      formatShortcut(keybinding.shortcut),
      escapeMarkdown(keybinding.action),
    ]),
  ];
  const columnWidths = rows[0].map((_, columnIndex) =>
    Math.max(...rows.map((row) => row[columnIndex].length)),
  );
  const renderRow = (row: string[]) =>
    `| ${row.map((cell, index) => cell.padEnd(columnWidths[index])).join(" | ")} |`;

  return [
    renderRow(rows[0]),
    renderRow(columnWidths.map((width) => "-".repeat(width))),
    ...rows.slice(1).map(renderRow),
  ].join("\n");
}

function readKeybindings(config: string): Keybinding[] {
  const keybindings: Keybinding[] = [];
  let section = "Other";

  for (const [lineIndex, line] of config.split("\n").entries()) {
    const trimmedLine = line.trim();
    const sectionMatch = trimmedLine.match(/^#\s+(.+)$/);
    if (sectionMatch) {
      section = sectionMatch[1];
      continue;
    }

    if (!trimmedLine.startsWith("bindsym ")) {
      continue;
    }

    const binding = trimmedLine.match(/^bindsym(?:\s+--\S+)*\s+(\S+)\s+(.+)$/);
    if (!binding) {
      throw new Error(
        `Could not parse bindsym on line ${lineIndex + 1} of ${configPath}`,
      );
    }

    keybindings.push({
      action: formatAction(binding[2]),
      section,
      shortcut: binding[1],
    });
  }

  return keybindings;
}

function renderReference(keybindings: Keybinding[]): string {
  const sections = Map.groupBy(keybindings, (keybinding) => keybinding.section);
  const renderedSections = [...sections].map(
    ([section, sectionKeybindings]) =>
      `## ${section}\n\n${renderTable(sectionKeybindings)}`,
  );

  return `<!-- This file is generated by scripts/generate-sway-keybindings.ts. Do not edit it directly. -->

# Sway keyboard reference

\`Mod\` is Super.

${renderedSections.join("\n\n")}`;
}

const reference = `${renderReference(readKeybindings(await Bun.file(configPath).text()))}\n`;
const existingReference = await Bun.file(outputPath)
  .text()
  .catch(() => undefined);

if (checkOnly) {
  if (reference !== existingReference) {
    console.error(
      `${outputPath} is stale. Run bun scripts/generate-sway-keybindings.ts.`,
    );
    process.exit(1);
  }
} else {
  await Bun.write(outputPath, reference);
}
