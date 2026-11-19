# Kickoff template: hand a big run to a fresh session

Copy everything below the line to `docs/superpowers/plans/<date>-<project>-kickoff.md` in the project repo, fill in every `<…>`, and delete what doesn't apply. Sections marked *(parallel)* are for runs whose plan splits into parts that write different files; a sequential run drops them. Keep the project's facts here and the method in `parallel-playbook.md`: point to the playbook rather than copying its rules in.

---

# <Project>: kickoff for the plan-and-build session

**To start:** open a new Claude Code session in `<repo path>` and send:

> Read docs/superpowers/plans/<date>-<project>-kickoff.md and follow it.

## 1. The job

<One or two sentences: what gets built, and how to weigh speed against safety.>

- **Design:** `<path to the approved design>`, approved on <date> ("<the user's words>"). Read all of it first. It's the source of truth, so don't reopen its decisions. <Where it lists the calls the user accepted, and what's left for you to decide.>
- **Working with the user:** <their role and what they decide>. Ask them only about content the design can't answer. <Memory rules that apply.>
- **Done means:**
  1. <each output exists where it should>
  2. <the checker passes: the exact command>
  3. A final review has run and its fixes are applied.
  4. Everything is merged to `<branch>` and pushed.
  5. The handover message (§7) is sent.
- **Not part of this job:** <what waits for the user, such as merging to main or publishing>.

## 2. Setup

- **Scratch folder:** `~/.superpowers/scratch/<repo>/<project>/`, with worktrees in its `worktrees/` subfolder. Give the path to every subagent.
- **Ledger:** `docs/superpowers/plans/<date>-<project>.progress.md`, with the scratch path on line 1. After every merge, record the task ID and SHA, and keep "in progress" and "next" current.
- **Branch:** everything branches from `<base>` and merges back into it. <Anything uncommitted to leave alone.>
- **Known failures:** <API errors seen before and what they mean; which model mechanical tasks fall back to>.

## 3. Ownership *(parallel)*

| Owner | Files |
|---|---|
| You | the ledger, the master plan, every merge |
| <part ID> | <files or patterns> |

- **Read-only for everyone:** <shared files, earlier versions, the design doc>. <How to change one instead, such as copying it to a new name.>
- **Worktree command:** `git worktree add ~/.superpowers/scratch/<repo>/<project>/worktrees/<task-id> -b <prefix>/<task-id> <base>`

## 4. Planning

- *Sequential run:* write the plan with `superpowers:writing-plans`, then execute it with `superpowers:subagent-driven-development`, one task at a time.
- *(parallel)* Write the master plan, then in one message dispatch the foundation builders and the planners, as the playbook's Master plan and Planners sections describe.

| Part | Plan file | Covers | Design sections |
|---|---|---|---|
| <ID> | `<plan path>` | <outputs> | <§> |

- **Foundation tasks:** <each one: what it builds and its check>.
- **Add to every planner's prompt:** <files to read first for this project>, <what "one task per output" means here>, <what the part's review checks>.

## 5. Building *(parallel)*

- **Dependencies:** <which tasks wait for which foundation tasks>.
- **Add to every builder's prompt:** <project-specific instructions beyond the playbook's list>.
- **Before each merge:** <project-specific checks, such as viewing each image>.

## 6. Finish

1. **Assemble** <the shared output> with `<script>`, then run `<checker>`. Fix failures with small tasks.
2. **Final review:** one read-only opus subagent checks <the output against the design and the writing rules; repetition across parts; names and numbers agreeing everywhere; images matching their captions; what a <domain expert> would catch>. Apply its findings as small tasks, then rerun the checker.
3. **Length:** report the word count. The user makes the cuts.
4. **Push** `<branch>`.
5. **Clean up:** remove every worktree and branch, move anything worth keeping into the repo and commit it, then delete `~/.superpowers/scratch/<repo>/<project>/` by that literal path.
6. **Update memory:** `<project memory file>`: what's built, where it is, and what waits for the user.

## 7. The handover message

Short, in plain words, in this order:
1. **What's done:** <paths, counts, checks passing, word count>.
2. **What to look at:** <anything the user asked to see, such as images or diagrams>.
3. **Rulings the user would notice:** only those that change what a reader sees.
4. **Open questions for experts:** <who, and what to confirm>.
5. **What waits for the user:** <merges, publishing, reviews>.
