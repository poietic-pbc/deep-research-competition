# Poietic Deep Research Competition

**Target:** KRAS G12D in pancreatic ductal adenocarcinoma (PDAC).
**Systems:** WorkGraph, Claude Code, Codex.
**Time budget:** 168 hours (7 days) per system, from its first commit.
**Result:** one public git history per system, three final reports, three
candidate therapeutics each. Everything inspectable. Nothing hidden.

---

## What this is

This repository is the public arena for a head-to-head demonstration run by
[Poietic PBC](https://poietic.life). Three AI research systems receive the
same prompt, the same time budget, and access to the same public scientific
tools. Each system's entire run, from first file to final report, is pushed
into this repository in real time. The commit history is part of the
deliverable.

The three systems:

- **[WorkGraph](https://github.com/graphwork/workgraph)**, Poietic's
  open-source multi-agent coordination graph. Specialist AI agents
  (cancer biologist, structural biologist, medicinal chemist, molecular
  designer, critic) and two humans (Erik, Luca) share one auditable task DAG.
- **Claude Code**, Anthropic's single-agent coding CLI in auto mode. One
  model, bash and file tools, end-to-end on its own.
- **Codex**, OpenAI's single-agent coding CLI. Comparable setup to Claude
  Code.

The research question is the same for everyone:

> Identify the most promising molecular targets for KRAS G12D in pancreatic
> ductal adenocarcinoma, then use generative AI tools to design exactly
> three therapeutic candidates (any modality) with reproducible methodology,
> predicted binding and activity, and an honest write-up of limitations.

The full brief, including the mandatory commit protocol and the required
report structure, is in [`prompt.md`](prompt.md).

## Why KRAS G12D in PDAC

- Pancreatic ductal adenocarcinoma has 5-year survival under 12 percent and
  kills more than 500,000 people per year worldwide.
- KRAS mutations drive roughly 90 percent of PDAC. KRAS G12D is the
  dominant allele and has no approved targeted therapy.
- KRAS was called undruggable for 40 years. Sotorasib (G12C, 2021) and
  Adagrasib (G12C, 2022) proved the class is tractable. G12D is the next
  frontier and is a current focus of every major oncology pipeline.
- The problem has rich structural data (PDB, AlphaFold), mature generative
  design tools (Boltz, RFdiffusion, DiffDock), and a well-characterized
  benchmark compound (MRTX1133), so it is feasible in a one-week sprint.

## Why we are running this

Two reasons.

**First, to stress-test AI-for-science systems on a problem that actually
matters.** Deep research demos usually produce a glossy report. We want to
see which systems can run a real pipeline for seven days, recover from tool
failures, and produce candidates that a medicinal chemist would take
seriously.

**Second, to show the difference auditability makes.** Claude Code and
Codex give you the final report and a git log. WorkGraph gives you the
same plus a browsable computation graph: which actor took which task,
which tool ran against which input, which edge depended on which. The
question is whether that structural transparency changes the quality of
the science, or just the quality of the write-up.

Either outcome is a useful result.

## How to follow along during the run

- Watch the repository. Every commit is pushed in real time.
- Per-system status is in each system's `RUN.md`:
  - [`systems/workgraph/RUN.md`](systems/workgraph/RUN.md)
  - [`systems/claude-code/RUN.md`](systems/claude-code/RUN.md)
  - [`systems/codex/RUN.md`](systems/codex/RUN.md)
- Tags mark the clock: `<system>-start` is hour 0, `<system>-final` is
  before hour 168.
- Per-system audit trail:

  ```bash
  git log workgraph-start..workgraph-final -- systems/workgraph/
  git log claude-code-start..claude-code-final -- systems/claude-code/
  git log codex-start..codex-final -- systems/codex/
  ```

- Progress notes land in `systems/<system>/progress/NNN-<slug>.md`.
  Tool outputs and figures land in `systems/<system>/artifacts/`.
- Final deliverables: `REPORT.md` and `candidates/candidates.json`
  at the root of each system's directory.

## How this repository is organized

```
deep-research-competition/
├── README.md              ← you are here
├── prompt.md              ← the frozen canonical prompt given to all 3 systems
├── OPERATOR.md            ← runbook for the human launching the systems
├── EVALUATION.md          ← scoring rubric applied after the deadline
├── REPORT_TEMPLATE.md     ← required structure for each system's REPORT.md
├── bootstrap.sh           ← one-shot gh setup (used once at repo creation)
├── LICENSE                ← MIT
└── systems/
    ├── workgraph/         ← WorkGraph's run lives here
    │   ├── README.md          system-specific launch notes
    │   ├── RUN.md             operator log (filled in during the run)
    │   ├── prompt.md          verbatim copy of the root prompt.md (hour 0)
    │   ├── progress/          ordered progress notes
    │   ├── artifacts/         raw tool outputs, figures, tool logs
    │   ├── candidates/        the three final candidates
    │   └── REPORT.md          the final report (hour 168)
    ├── claude-code/       ← Claude Code's run (same shape)
    └── codex/             ← Codex's run (same shape)

# Added after the deadline:
# meta/
# ├── scores.md            ← independent reviewers' scores
# ├── analysis.md          ← co-founders' comparative analysis
# └── rulings.md           ← any disqualification rulings
```

## The rules (summary)

Full text in [`prompt.md`](prompt.md). Short version:

- **168 hours from first commit.** No valid `REPORT.md` by hour 168, or
  final commit pushed after hour 168, is disqualification.
- **Commit everything.** Every non-trivial output is committed the moment
  it is produced. Nothing cited in the final report may exist only in
  memory or on scratch disk.
- **Commit at least once every 24 hours** while active. Three consecutive
  missed windows without explanation is disqualification.
- **Exactly three candidates** per system, in the schema defined in
  `prompt.md` §4. Invalid SMILES or fabricated citations are
  disqualification.
- **No history rewrites.** Force-push, rebase, amend on published commits,
  or backdated timestamps is disqualification. Branch protection on `main`
  blocks this at the GitHub side.

## How the scoring works

After hour 168 for all three systems, the co-founders and at least two
external reviewers (one medicinal chemist, one AI-for-science researcher)
score each run independently on four dimensions:

- **Endurance.** Did the system complete the pipeline without failing?
- **Quality.** Are the molecules chemically plausible? Do the rationales
  reflect current literature?
- **Depth.** Actual molecular design with non-trivial reasoning, or
  literature review with candidates tacked on?
- **Auditability.** Can a third party trace every conclusion from the
  commit history alone?

Scores and written justifications are published in `meta/scores.md`. There
is no single "winner". The output is a credible head-to-head the community
can inspect and reproduce. Full rubric: [`EVALUATION.md`](EVALUATION.md).

## Reproducing the evaluation

After the deadline, anyone can re-score the competition from the tags:

```bash
gh repo clone poietic-pbc/deep-research-competition
cd deep-research-competition

# Pull a specific system's final state into a scratch worktree:
for sys in workgraph claude-code codex; do
  git worktree add ../score-$sys ${sys}-final
done

# Then read each ../score-<sys>/systems/<sys>/REPORT.md, verify every claim
# against the artifacts under systems/<sys>/artifacts/ and the commit log,
# and score against EVALUATION.md.
```

The repository is the evidence base. If you can reproduce a scoring
disagreement with us from the public history, file an issue.

## Running your own system in this arena

Yes, you can. After the primary three runs are done, we will accept pull
requests that add a new `systems/<your-system>/` subdirectory, following
the same rules. Open an issue first to coordinate so the timing and setup
match. The intent is that this repository becomes a venue, not a one-off.

## Status

- **Repository created:** 2026-04-23
- **Competition window:** opens when the first `<system>-start` tag is
  pushed. See each `systems/<system>/RUN.md` for per-system clocks.
- **Expected first run:** May 2026. Erik leads. See the per-system RUN.md
  for authoritative start times.
- **Scoring window:** within 14 days after the last `<system>-final` tag.

## Team and contact

- **Erik Garrison**, co-founder and WorkGraph lead. erik.garrison@gmail.com
- **Luca Pinello**, co-founder, computational genomics and AI for biology.
  lucapinello@gmail.com
- **Vaughn Tan**, co-founder, organizational design and operations.
  me@vaughntan.org

Questions, reviewer interest, or press: open a GitHub issue, or email any
of the above.

## License

MIT. See [`LICENSE`](LICENSE). The intent is that anyone can reuse the
competition structure (`prompt.md`, `OPERATOR.md`, `EVALUATION.md`,
`REPORT_TEMPLATE.md`, directory layout, scoring rubric) to stand up an
equivalent head-to-head on a different scientific problem.

## Related

- [poietic.life](https://poietic.life), Poietic PBC
- [github.com/graphwork/workgraph](https://github.com/graphwork/workgraph),
  the WorkGraph repository
- [graphwork.github.io](https://graphwork.github.io), WorkGraph docs
