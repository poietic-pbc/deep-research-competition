# Claude Code run

This is Claude Code's arena. All Claude Code work during the competition
lives under this directory.

## What Claude Code is

Claude Code is Anthropic's single-agent CLI: one model, bash and file tools,
auto-approved within the project directory. No built-in multi-agent
coordination; the model drives itself through the task end-to-end.

## Before launch

From the repo root:

```bash
cd systems/claude-code
cp ../../prompt.md ./prompt.md
shasum -a 256 ./prompt.md  # record in RUN.md
$EDITOR RUN.md              # fill in placeholders
```

Confirm Claude Code has shell access to the tools the prompt allows
(rdkit, docker, python, git, gh). Claude Code will commit and push on its
own; test with a dummy commit before handing it the real prompt.

## Launch

Start Claude Code inside this directory with `prompt.md` as the initial
turn. Recommended command:

```bash
cd systems/claude-code
claude --model claude-opus-4-7 --permission-mode acceptEdits < prompt.md
```

The `--permission-mode acceptEdits` flag lets Claude commit on its own. The
operator still watches; see `../../OPERATOR.md`.

If the session ends (context window, tool crash, operator pause), resume
with:

```bash
claude --resume
```

Record every launch and resume in `RUN.md`.

## Hour-168 deliverable specifics

Same universal requirements as all three systems:

- `systems/claude-code/REPORT.md`
- `systems/claude-code/candidates/candidates.json` (three candidates)
- `systems/claude-code/candidates/<id>/` per candidate
- `systems/claude-code/progress/*.md` progress notes
- `systems/claude-code/artifacts/` tool outputs
- `systems/claude-code/RUN.md` (completed)

No equivalent to WorkGraph's computation-graph.html. The git history is
the audit trail.
