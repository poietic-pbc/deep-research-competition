# This repository is archived.

As of 2026-04-24, this scaffold is no longer the active demonstration for
Poietic PBC's Google.org Impact Challenge application.

## Why

The original plan (a one-week three-way competition on KRAS G12D
pancreatic cancer drug discovery) was cut after honest review. The
structural problems could not be fixed in the available time: the team
has no independent track record in oncology drug discovery, no wet-lab
partner, no preliminary data, outputs would be unvalidated computational
artifacts, and a sophisticated reviewer would read the format as
constructed.

## What replaced it

The active scaffold is now at:

**[poietic-pbc/phr-methodology-comparison](https://github.com/poietic-pbc/phr-methodology-comparison)**

The replacement is a three-arm **methodology comparison** (not a benchmark
contest) on pseudo-homologous region (PHR) discovery in a defined
pangenome interval. The three arms:

1. **WorkGraph** with a domain expert (Erik Garrison) in the loop
2. A **single-session agentic CLI** (Claude Code or Codex) running autonomously
3. A **skilled bioinformatician** working alone with vg/PGGB

PHR is Erik's own published work (Nature 2023). The comparison asks what
each architecture's output looks like, not who wins. That framing is
deliberate.

## What this repository still contains

The scaffold files (`prompt.md`, `OPERATOR.md`, `EVALUATION.md`,
`REPORT_TEMPLATE.md`, per-system directories, `bootstrap.sh`,
`.gitignore`) are preserved here as a historical artifact. Anyone curious
about the infrastructure pattern can see how the scaffold was built. None
of the scientific content (KRAS G12D, molecular design, MRTX1133, Boltz,
RFdiffusion, DiffDock) reflects Poietic PBC's current plan.

Follow the active work at the replacement repository above.
