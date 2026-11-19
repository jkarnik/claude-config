# Parallel planning and execution: playbook

Read this before writing the master plan for a run whose plan splits into 2+ parts that write different files. CLAUDE.md's Parallel Planning and Execution rule says when it applies; this file says how to run it. When the run is handed to a fresh session, `kickoff-template.md` holds the project's specifics and this file holds the method.

## Master plan

You write it first and keep it short: at most ~150 lines, written in parts. It holds:
- the parts and their dependencies;
- an **ownership table** giving every file the project creates or changes exactly one owner. Everything unowned is read-only for everyone;
- the **foundation tasks** other parts need first (shared helpers, checkers, tool fixes), written in full.

**Small project:** write one plan yourself and run only its independent tasks in parallel.

## Planners

- In **one message**, dispatch the foundation builders and one planner per part. Each planner writes only its own plan file.
- Every planner's prompt says:
  1. Read first: the design, the master plan's ownership table, and every file its tasks start from.
  2. Use the `superpowers:writing-plans` task format, written in parts of at most 100 lines.
  3. Open with a **values table**: every name, number, time, label and path the part's outputs show. Where the design leaves a value open, pick a concrete one. Tasks built from the table, such as a screen and the text describing it, can then run at the same time and still agree.
  4. Plan one task per output (image, section, module). A new shared helper gets its own earlier task.
  5. Every task names its files (all owned by the part), inputs, steps, acceptance checks as exact commands with expected results, dependencies, and commit message.
  6. Every task passes the sizing test in CLAUDE.md. Split anything bigger.
  7. Task IDs carry the part's prefix: S2-1, S2-2, and so on.
  8. The last task is a read-only review on opus. It checks the part's outputs against each other and against the design, and reports findings.
  9. Never plan an edit to another part's file. List it under **Requests** at the end of the plan.
  10. Finish with a self-check against the design sections the part covers.
  11. Return the plan's path, its task IDs and dependencies, its Requests, and any design gaps. Decide the minor gaps and list them as proposed rulings.
- **Check each plan as it lands:** ownership, values table, sizing, concrete checks. Fix small problems yourself and record the rulings. Answer its Requests by deciding them or assigning them to the file's owner. Then commit the plan.
- If a planner dies twice, write that plan yourself.

## Builders

- **Start each part as soon as its plan lands**, and each task as soon as its dependencies have merged. Never wait for all the plans.
- **One task per subagent, each in its own worktree and branch** under `~/.superpowers/scratch/<repo>/<project>/worktrees/<task-id>`. Create each worktree yourself just before dispatch, because parallel `git worktree add` calls race.
- Every builder's prompt holds:
  - where its task is: point at the task in its plan file rather than pasting the task in;
  - the scratch path and the task's worktree;
  - "touch only the files this task lists";
  - "run the acceptance checks and paste their output";
  - "commit in the worktree; don't merge or push";
  - "spawn no agents".
- **One flat layer of subagents.** How many run at once follows the hardware check in CLAUDE.md's Task Decomposition. Mechanical tasks (scripts, widgets, renders, exact text replacements) run on sonnet. Plans, prose and reviews run on opus.

## Merging and the ledger

- **Only you merge,** one at a time with `--no-ff`, after rerunning the task's checks in its worktree and viewing any image yourself. Then update the ledger and remove the worktree and branch.
- A merge conflict means ownership broke: stop and find out why.
- **Only you write the ledger:** every merge SHA, every ruling (flag the ones a reader would notice), and a running list of choices later tasks must respect, such as wording other parts already used.

## Failures

- Every agent's prompt, whether planner, builder or reviewer, says "write your files early and in small pieces", so a timeout loses little. A reviewer appends each finding to its findings file as soon as it has one.
- Resume a dead agent once. If it dies again, dispatch a fresh one with a smaller brief.
- If the errors point at the user's environment (network, proxy, login), tell the user and keep the other work going.
- If one model keeps failing, mechanical tasks may move to another. Keep prose and reviews on opus.

## Reviews

- When a part's last task merges, run its review and turn the findings into small fix tasks on that part's files.
- At the end, run focused final reviews in parallel (for example text, visuals, a domain expert), then a fix round, then a check of the fixes.

## Shared outputs

Outputs that several parts feed (one document, an index) are assembled from per-part fragments by a script. Its checker also runs on a single fragment, so each part can check its own fragment before assembly.
