# Codex run

This is Codex's arena. All Codex work during the competition lives under
this directory.

## What Codex is

Codex is OpenAI's single-agent coding CLI: one model, shell and file tools,
auto-mode within the project directory. No built-in multi-agent
coordination; the model drives itself through the task end-to-end.

## Before launch

From the repo root:

```bash
cd systems/codex
cp ../../prompt.md ./prompt.md
shasum -a 256 ./prompt.md  # record in RUN.md
$EDITOR RUN.md              # fill in placeholders
```

Confirm Codex has shell access to the tools the prompt allows (rdkit,
docker, python, git, gh). Codex will commit and push on its own; test with
a dummy commit before handing it the real prompt.

## Launch

Start Codex inside this directory with `prompt.md` as the initial turn.
Recommended command (adjust for the current Codex CLI version):

```bash
cd systems/codex
codex --auto --model <current-codex-model> < prompt.md
```

Operator may need to authorize sudo or network access depending on Codex's
sandbox profile. Record any such authorization in `RUN.md`.

If the session ends, resume with whatever Codex's resume flow is
(`codex --resume` or equivalent). Record every launch and resume in
`RUN.md`.

## Hour-168 deliverable specifics

Same universal requirements as all three systems:

- `systems/codex/REPORT.md`
- `systems/codex/candidates/candidates.json` (three candidates)
- `systems/codex/candidates/<id>/` per candidate
- `systems/codex/progress/*.md` progress notes
- `systems/codex/artifacts/` tool outputs
- `systems/codex/RUN.md` (completed)

The git history is the audit trail.
