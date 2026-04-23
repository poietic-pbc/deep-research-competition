# WorkGraph RUN.md

Fill in every `<placeholder>` at hour 0. Update the "Progress log" and
"Pause windows" sections throughout the run. Complete the "Post-run" section
at hour 168.

## Identity

- **System:** WorkGraph
- **Version / commit:** <workgraph git commit SHA>
- **Operator name:** <your name>
- **Operator email:** <your email>
- **Machine hostname:** <hostname>
- **OS / hardware:** <e.g. Ubuntu 24.04, 128 GB RAM, 1x NVIDIA H100>

## Clock

- **Start timestamp (UTC):** <YYYY-MM-DDTHH:MM:SSZ>
- **Planned deadline (UTC):** <start + 168h>
- **Prompt SHA-256:** <sha256 of systems/workgraph/prompt.md at start>

## Tool versions pinned at start

- workgraph: <commit>
- Python: <version>
- RDKit: <version>
- AlphaFold / Boltz: <version>
- RFdiffusion: <commit>
- DiffDock: <commit>
- <add every tool the system uses, with its pinned version>

## Actor roster (at start)

- cancer-biologist (agent, <model>)
- structural-biologist (agent, <model>)
- medicinal-chemist (agent, <model>)
- molecular-designer (agent, <model>)
- critic (agent, <model>)
- erik (human)
- luca (human)

## Progress log

Appended each time the operator checks in. Most granular per-task logging
lives in `.workgraph/graph.jsonl` and per-step notes in `progress/`.

- `<timestamp UTC>` — <note>

## Pause windows

Any interval during which the system was not actively working. Counts
against the 168h budget. Format: `start — end — reason`.

- <none yet>

## Operator interventions

Every judgment call the operator made. The scientist work must come from
agents and co-founders acting as agents, not from the operator.

- <none yet>

## Post-run (fill at hour 168)

- **Actual end timestamp (UTC):** <...>
- **Actual wall-clock used:** <HH:MM:SS out of 168h>
- **Total commits by the system:** <N>
- **Total commits by operator on the system's behalf:** <N>
- **Total tool invocations:** <N>
- **Link to computation graph:** `systems/workgraph/computation-graph.html`
- **Top three surprises:**
  1. <...>
  2. <...>
  3. <...>
- **What I would change next time:** <...>
