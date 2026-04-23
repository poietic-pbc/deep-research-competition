# Evaluation Rubric

After hour 168 for all three systems, the co-founders score each run
independently on the four dimensions below. Scores are posted to
`meta/scores.md` along with written justifications. The co-founders may also
invite two external reviewers (one medicinal chemist, one AI-for-science
researcher) whose scores are published alongside.

No score is tallied into a single "winner". The competition is a public
demonstration, not a leaderboard. What we want is a credible head-to-head
that the community can inspect, critique, and reproduce.

## Dimensions

### 1. Endurance (0-5)

Did the system complete the full pipeline without failing?

- **5.** Ran end to end. Hit every milestone (targets, design, docking,
  report). No silent dropouts. Failures recovered gracefully with logged
  decisions.
- **3.** Completed the report but skipped or abandoned a pipeline stage, or
  required heavy operator intervention.
- **1.** Produced a report but large parts are placeholder, or most stages
  never actually ran.
- **0.** Did not produce a valid final commit, or disqualified.

Primary evidence: commit history, `RUN.md`, `progress/` notes.

### 2. Quality (0-5)

Are the molecules chemically plausible? Do the rationales reflect the
current literature?

- **5.** Candidates are novel, chemically reasonable, and grounded in cited
  primary literature. Mechanisms are specific to KRAS G12D and PDAC.
  Benchmarking against MRTX1133 and other prior art is honest and correct.
- **3.** Candidates are plausible but derivative, or citations are mostly
  correct but some claims float free. Mechanistic story is directionally
  right but shallow.
- **1.** Obvious errors in chemistry, reaction feasibility, or target
  biology. Citations are thin or wrong.
- **0.** Fabricated citations, non-parseable structures, or gibberish.

Primary evidence: `REPORT.md`, `candidates/candidates.json`, `candidates/<id>/`
artifacts, literature citations cross-checked against PubMed.

### 3. Depth (0-5)

Surface-level summary, or actual molecular design with non-trivial reasoning?

- **5.** The system engaged real structure-based reasoning: it looked at the
  switch-II pocket, ran docking, iterated on scaffolds, evaluated binding
  modes, discussed selectivity against wild-type RAS, and considered PDAC
  microenvironment. Evidence for each step is in the artifacts.
- **3.** Did the design work but stopped at a first-pass result. Limited
  iteration. Some parts are literature summary rather than design.
- **1.** Mostly a literature review with three candidates tacked on.
- **0.** Candidates appear to be copy-pasted from a database with no design.

Primary evidence: `progress/` notes, tool-invocation ledger, intermediate
artifacts, iteration depth visible in commit history.

### 4. Auditability (0-5)

Can a third party trace every conclusion from the commit history alone?

- **5.** Every claim in the report maps to a specific artifact and commit.
  The provenance table is complete. Tool invocations are logged with inputs,
  outputs, and versions. For WorkGraph, the computation graph is browsable
  and matches the git history.
- **3.** Major results are traceable but smaller claims are not. Tool log
  exists but is incomplete.
- **1.** The report reads reasonably but the evidence trail is thin. Most
  numbers cannot be backed out of the repository.
- **0.** Report claims cannot be reproduced from the repository.

Primary evidence: the repository itself. This dimension is the one
WorkGraph is built to win, and the one most sensitive to whether "deep
research" AI actually works in production.

## Process

1. Each reviewer clones the repository at the `<system>-final` tag for each
   system and scores independently. No cross-talk until all scores are in.
2. Reviewers publish scores and written justifications in `meta/scores.md`.
3. Co-founders write a joint comparative analysis in `meta/analysis.md`.
4. If any reviewer flags a disqualification condition (see `prompt.md` §7),
   the co-founders rule in `meta/rulings.md` before final scores are posted.

## Not scored

- Total runtime. The 168-hour budget is fixed. Using less is not a win.
- Number of commits. More is not better; the question is whether each
  commit carries real content.
- Report length. Above the 2,000-word floor, more is not better.
- Pretty figures. Clarity matters, aesthetics do not.
