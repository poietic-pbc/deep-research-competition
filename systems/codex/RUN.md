# Codex RUN.md

Fill in every `<placeholder>` at hour 0. Update the "Progress log" and
"Pause windows" sections throughout the run. Complete the "Post-run" section
at hour 168.

## Identity

- **System:** Codex
- **Model:** <e.g. gpt-5-codex or current>
- **CLI version:** <output of `codex --version`>
- **Operator name:** <your name>
- **Operator email:** <your email>
- **Machine hostname:** <hostname>
- **OS / hardware:** <e.g. Ubuntu 24.04, 128 GB RAM, 1x NVIDIA H100>

## Clock

- **Start timestamp (UTC):** <YYYY-MM-DDTHH:MM:SSZ>
- **Planned deadline (UTC):** <start + 168h>
- **Prompt SHA-256:** <sha256 of systems/codex/prompt.md at start>

## Launch invocation

The exact command used to start Codex with `prompt.md`:

```
<paste launch command>
```

Auto mode / sandbox profile: <...>

## Tool versions pinned at start

- Codex CLI: <version>
- Python: <version>
- RDKit: <version>
- AlphaFold / Boltz: <version>
- RFdiffusion: <commit>
- DiffDock: <commit>
- <add every tool the system uses, with its pinned version>

## Resumes

Each time the session was resumed.

- `<timestamp UTC>` — reason: <...>

## Progress log

- `<timestamp UTC>` — <note>

## Pause windows

- <none yet>

## Operator interventions

- <none yet>

## Post-run (fill at hour 168)

- **Actual end timestamp (UTC):** <...>
- **Actual wall-clock used:** <HH:MM:SS out of 168h>
- **Number of Codex sessions:** <N>
- **Total commits by Codex:** <N>
- **Total commits by operator on Codex's behalf:** <N>
- **Total tool invocations:** <N>
- **Top three surprises:**
  1. <...>
  2. <...>
  3. <...>
- **What I would change next time:** <...>
