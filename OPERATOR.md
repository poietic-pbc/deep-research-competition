# Operator Runbook

You are the human driving the three AI systems on a workstation. This file is
your runbook. Follow it in order. If something is ambiguous, write it down in
the system's `RUN.md` instead of guessing.

## 0. Before you start

- Budget yourself at least 8 hours of attention per system during the first
  day, and at least a daily 20-minute check-in for the remaining six.
- Systems may run sequentially (one week each, three weeks total) or in
  parallel (three machines, three operators, one shared week). Either is
  acceptable. Record which in `RUN.md`.
- If you run in parallel, each system gets its own machine, its own checkout,
  and its own git user. Commits go to the same repository under different
  subdirectories, so concurrent pushes are safe as long as each operator
  `git pull --rebase origin main` before pushing.

## 1. One-time workstation setup

### 1.1 Tools on the machine

Minimum:

- git >= 2.40
- gh CLI, authenticated with an account that can push to this repository
- Python 3.11+ with venv
- conda or mamba for bioinformatics tooling
- Docker (for running structure prediction and protein design models)
- 200 GB free disk (model weights and intermediate outputs)
- GPU access strongly recommended for Boltz, RFdiffusion, DiffDock

Per-system specifics: see the README.md in each `systems/<system-name>/`
subdirectory.

### 1.2 Clone and identity

```bash
gh repo clone poietic-pbc/deep-research-competition
cd deep-research-competition
git config user.name  "Your Name"
git config user.email "you@example.com"
```

The committer identity is part of the audit trail. Use a real email you own.

### 1.3 Verify auth and write access

```bash
gh auth status
git push --dry-run
```

Both must succeed before you proceed.

## 2. Per-system launch procedure

Do this once for each of the three systems. The order is up to you, but do
not interleave system runs (i.e. don't pause WorkGraph to start Claude Code;
finish each hour-0 bootstrap cleanly before moving on).

### 2.1 Pick your system

Set `SYS` to one of `workgraph`, `claude-code`, `codex`:

```bash
export SYS=workgraph   # or claude-code, or codex
cd systems/$SYS
```

### 2.2 Verify the prompt is frozen

The root `prompt.md` defines the task. Copy it verbatim and hash-check:

```bash
cp ../../prompt.md ./prompt.md
diff ../../prompt.md ./prompt.md   # must be empty
shasum -a 256 ./prompt.md          # record this hash in RUN.md
```

### 2.3 Fill in RUN.md

Open `RUN.md`, fill in every `<placeholder>`. Leave the "completion" section
empty for now. Record:

- system name
- start timestamp (UTC), planned deadline (start + 168h)
- operator name and email
- machine hostname, OS, hardware summary
- tool versions pinned at start (git commit, docker images, conda env hash)

### 2.4 The hour-0 commit

From the repo root:

```bash
git add systems/$SYS/
git commit -m "$SYS: start (hour 0)"
git tag ${SYS}-start
git pull --rebase origin main
git push origin main --tags
```

The `git pull --rebase` is the safety valve if another operator is
concurrently running another system. The `--tags` flag publishes the tag.

### 2.5 Launch the system

See `systems/$SYS/README.md` for the exact command to start the AI system
with `prompt.md` as its initial task.

In short:

- **WorkGraph:** `wg actor add` the specialists and humans, then `wg task add`
  the top-level task with `prompt.md` as its spec, then `wg serve`.
- **Claude Code:** `claude --auto` in the `systems/claude-code/` directory
  with `prompt.md` pasted as the initial message.
- **Codex:** equivalent CLI flow, `codex --auto` in `systems/codex/`.

Capture the process PID, the log file path, and the launch command in
`RUN.md`.

## 3. During the run

### 3.1 Commit hygiene

The AI system is instructed to commit its own artifacts. In practice, some
systems will forget. Check every 4-6 waking hours:

```bash
cd deep-research-competition
git status systems/$SYS/
git log --since='24 hours ago' -- systems/$SYS/
```

If files have been produced but not committed, you commit them with a
message that names the step and notes that the operator committed on the
system's behalf:

```bash
git add systems/$SYS/
git commit -m "$SYS: operator-commit <step-name> (artifacts were unstaged)"
```

Never squash, never amend, never backdate.

### 3.2 The 24-hour rule

At least one commit into `systems/$SYS/` must land every 24 hours. If you
notice the system has been idle and has not committed in 20 hours, either:

1. Prompt the system to checkpoint its current state and commit, or
2. Append an entry to `systems/$SYS/RUN.md` explaining the idle window
   (tool still running, operator paused for sleep, etc.) and commit that
   update as the heartbeat.

Three missed 24-hour windows without explanation is disqualification.

### 3.3 When things break

Tools crash. Models run out of memory. GPUs go down. Record it. Commit the
stack trace or the error log to `artifacts/`. Update `RUN.md`. Resume.

If you must move to a different machine mid-run: commit everything, push,
clone on the new machine, update `RUN.md` with the new hostname, continue.
Time keeps running.

### 3.4 What not to do

- Do not edit `prompt.md` after hour 0.
- Do not delete files from `artifacts/` or `progress/`.
- Do not rebase, squash, or amend published commits.
- Do not help the AI system do science. You are the operator, not the
  scientist. You may fix tool invocations and push commits the system
  forgot, but you do not choose targets, design molecules, or write the
  report body. Log any judgment call you made in `RUN.md`.

## 4. The hour-168 finish

When the system signals it is done, or when you approach hour 168:

### 4.1 Completeness check

From `systems/$SYS/`:

```bash
test -f REPORT.md                                    || echo "MISSING REPORT"
test -f candidates/candidates.json                   || echo "MISSING candidates.json"
python -c "import json; d=json.load(open('candidates/candidates.json')); assert len(d)==3, len(d)"
ls candidates/C1 candidates/C2 candidates/C3 >/dev/null || echo "MISSING candidate dirs"
```

If anything prints or fails, the system has not finished. Push it back for
another pass or commit a note explaining the gap.

### 4.2 Final commit

```bash
git add systems/$SYS/
git commit -m "$SYS: final (hour HH:MM:SS)"
git tag ${SYS}-final
git pull --rebase origin main
git push origin main --tags
```

The commit must land before hour 168, measured against the server-side
timestamp on GitHub. If you push at hour 167:58 and the push races with
another operator's rebase, retry immediately. Do not improvise.

### 4.3 Post-mortem

After the final tag is pushed, append a short post-mortem to `RUN.md`:

- total wall-clock used
- total commits by the system vs by the operator
- the three biggest surprises, good and bad
- what you would change about the setup next time

This is part of the deliverable.

## 5. If you hit a disqualification condition

If you believe the run has been disqualified (missed deadline, force-push,
fabricated data), stop immediately, commit the current state with
`$SYS: DQ_CANDIDATE` in the message, and open a GitHub issue with the
evidence. The co-founders will rule. Continuing to commit after a suspected
DQ only makes the audit harder.
