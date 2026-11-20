# claude-config

Shared global instructions for Claude Code: how it breaks down, plans and runs work, including parallel subagents, and how it writes documents people read.

They're written for a product manager who doesn't review code, so Claude makes the technical calls itself. If that isn't you, change the User Role section (setup step 4).

## What's inside

| File | What it does |
|---|---|
| `CLAUDE.md` | The rules Claude loads in every session |
| `reference/parallel-playbook.md` | How to plan and run a job in parallel parts without clashes |
| `reference/kickoff-template.md` | A fill-in file for handing a big job to a fresh session |
| `reference/writing-for-readers.md` | How to apply the writing rules, with examples |
| `reference/pptx-rendering.md` | How to render PowerPoint slides to images |
| `Claude-desktop/CLAUDE-desktop.md` | The rules that suit the Claude desktop app's mail, Slack, docs and Jira work, to paste into its settings |
| `Claude-desktop/desktop-hourly-brief.md` | A scheduled task for the desktop app: a full brief each morning, then hourly updates, with replies drafted but never sent |
| `install.sh` | Links `CLAUDE.md` and `reference/` into `~/.claude` |
| `personal.example.md` | The starting point for your own `~/.claude/personal.md` |

## Setup

1. Install the superpowers plugin, which the rules rely on. In Claude Code, run `/plugin install superpowers@claude-plugins-official`.
2. Clone the repo anywhere: `git clone https://github.com/jkarnik/claude-config.git`
3. In the repo folder, run `./install.sh --dry-run` to see what will change, then `./install.sh`. It renames anything already at `~/.claude/CLAUDE.md` or `~/.claude/reference` to `<name>.backup-<timestamp>`, links both to the repo, and creates `~/.claude/personal.md` from `personal.example.md` if you don't have one.
4. Edit the User Role section of `CLAUDE.md`: your role, your domain, and which decisions you want to make yourself.
5. Put anything private or true only on your machine in `~/.claude/personal.md`: local paths, your employer's internal tools, accounts, people. That file is never committed, and CLAUDE.md tells Claude to keep such notes there too.
6. Start a new Claude Code session and run `/memory` to check that both files are listed.

## How it loads

- Claude Code reads `~/.claude/CLAUDE.md` at the start of every session.
- The line `@~/.claude/personal.md` at the end of CLAUDE.md pulls your personal file in at the same moment.
- A reference file is read only when its pointer in CLAUDE.md applies (for example "Before writing the master plan, read …"), so its detail doesn't crowd the session until then.

## Updating

Run `git pull` in the repo; the next session picks up the changes. If you've changed CLAUDE.md, commit your change first, then run `git pull --no-rebase`: git combines the two and stops to ask only where both changed the same lines.

## Caveats

- Claude's Edit and Write tools refuse to write through a symlink, so Claude edits these files at their real path in the repo.
- Cowork sessions in the Claude desktop app skip a symlinked `~/.claude/CLAUDE.md` and any import outside the session's folder. To give Cowork the rules that suit its work, paste `Claude-desktop/CLAUDE-desktop.md` into Settings > Cowork > Global instructions, after swapping the notes under its last heading for your own. Copying `CLAUDE.md` in instead would also load the rules about plans, subagents and worktrees.
- On Windows, symlinks need Developer Mode.

## Undo

Delete the links `~/.claude/CLAUDE.md` and `~/.claude/reference`, then rename the `.backup-*` copies back.

## License

MIT. You can copy, change and share these files, as long as copies keep the notice in [LICENSE](LICENSE).
