# Deep Research Competition, Canonical Prompt v1

**This is the identical prompt given to every competing system.** Do not edit
it during a run. A verbatim copy of this file must be committed into each
system's working directory as the first artifact.

Three systems compete on the same task: **WorkGraph**, **Claude Code**, and
**Codex**. Each system is given exactly one week of wall-clock time from its
first commit. All work is committed and pushed in real time to a single public
GitHub repository (this one), under `systems/<system-name>/`. The commit
history itself is part of what we evaluate.

If you are the AI system, read every section below and follow it literally.
If you are the human operator, see `OPERATOR.md` first, then hand this file
to the AI system as its initial task.

---

## 1. The task

> Given the current state of knowledge about pancreatic ductal adenocarcinoma
> (PDAC) and the KRAS G12D mutation, identify the most promising molecular
> targets, then use available generative AI tools to design exactly **three
> candidate therapeutic molecules**. Candidates may be any modality: small
> molecules, peptides, cyclic peptides, macrocycles, targeted protein
> degraders (PROTACs, molecular glues), engineered proteins, aptamers, or
> mRNA payloads. Produce a final report covering target rationale, design
> methodology, predicted binding and activity, and an honest assessment of
> limitations.

### 1.1 Scientific expectations

- **Ground your target selection in the current literature.** Cite primary
  papers by PubMed ID (PMID) or DOI. Do not invent citations. If you cannot
  verify a citation, drop the claim.
- **Be specific to KRAS G12D in PDAC**, not KRAS in general. The G12C story
  (Sotorasib, Adagrasib) is precedent, not answer. Explain what is different
  about G12D and about the PDAC microenvironment.
- **Benchmark against known art.** At minimum, compare your candidates to
  MRTX1133 (Mirati's pan-KRAS / G12D-selective inhibitor) and, if relevant,
  to known pan-KRAS degraders, RAS-SOS1 inhibitors, and allele-specific
  antibodies or TCR-mimic approaches. Your candidates should be novel with
  respect to published structures or clearly explain why they are not.
- **Diversity is encouraged but not required.** You may submit three small
  molecules, or one of each modality. Either way, each candidate must have a
  distinct mechanistic story.
- **No fabricated data.** If a tool fails or returns a low-confidence
  prediction, say so. Report the actual numbers, not round ones.

### 1.2 Tools you may use

Any public tool or dataset is fair game. Expected primary tools include:

- **Structure:** AlphaFold, Boltz, ESMFold, RoseTTAFold, Protein Data Bank (PDB)
- **Protein design:** RFdiffusion, ProteinMPNN, ESM-IF, Chroma
- **Docking:** DiffDock, AutoDock Vina, Smina, Glide (if licensed)
- **Cheminformatics:** RDKit, Open Babel, Datamol, ChEMBL, PubChem, ZINC22
- **ADMET / druglikeness:** ADMET-AI, SwissADME, DeepPurpose, pkCSM
- **Degrader design:** PROTAC-DB, MOAD, any open PROTAC linker generators
- **Literature:** PubMed / NCBI E-utilities, bioRxiv, Europe PMC, Semantic Scholar
- **Sequence / expression:** UniProt, GTEx, DepMap, CCLE

You are not required to use every tool. You **are** required to log every tool
invocation (input, output, version) into the repository.

### 1.3 Hard constraints

- **Exactly three candidates.** Not two, not four. The final report and the
  `candidates/` directory must contain three, and only three.
- **Every candidate must be machine-readable.** Small molecules as canonical
  SMILES parseable by RDKit. Peptides and proteins as single-letter amino acid
  sequences. Degraders as SMILES with explicit warhead, linker, and E3 ligand
  identification. Structured candidate metadata must be committed as JSON,
  schema in §4.
- **No wet-lab work is expected.** All "activity" claims are *predicted*
  activity from public tools. Do not claim experimental data you did not run.
- **No synthesis of harmful compounds.** Cancer therapeutics are in scope;
  anything outside the KRAS G12D / PDAC brief is out of scope.

---

## 2. Time limit

You have **exactly 168 hours (7 calendar days)** from your first commit into
`systems/<system-name>/`. The first commit starts the clock. A valid final
commit must land **before** hour 168.

- No valid `REPORT.md` committed by hour 168, or a final commit pushed after
  hour 168: **disqualified**.
- Force-pushing, rewriting history, backdating commits, or rebasing the
  competition branch after the deadline: **disqualified**.
- Hour 168 is measured against the actual commit timestamps in the GitHub
  repository, as recorded server-side.

Pausing is permitted. Time keeps running. If the human operator halts the
system to sleep or move to another machine, `RUN.md` must record the pause
window. Pause time counts against your 168 hours.

---

## 3. Commit protocol (mandatory)

Every non-trivial step produces an artifact and the artifact is committed. The
repository is the work. Anything not in the repository did not happen.

### 3.1 Hour-0 start commit

Your first commit into `systems/<system-name>/` must be tagged from the command
line as `<system-name>-start` and must contain:

- `systems/<system-name>/RUN.md`, filled in from the template at
  `systems/<system-name>/RUN.md` (the checked-in template is a skeleton with
  placeholders). Required fields: system name, start timestamp in UTC, planned
  deadline timestamp (start + 168h), operator name, machine hostname, tool
  versions pinned as of start.
- `systems/<system-name>/prompt.md`: a verbatim copy of this file. Hash check:
  the SHA-256 of your copy must match the SHA-256 of `prompt.md` at the repo
  root at the time of start.
- `systems/<system-name>/progress/` (empty dir is fine, via `.gitkeep`).
- `systems/<system-name>/artifacts/` (empty dir via `.gitkeep`).
- `systems/<system-name>/candidates/` (empty dir via `.gitkeep`).

Example:

```bash
git add systems/workgraph/
git commit -m "workgraph: start (hour 0)"
git tag workgraph-start
git push origin main --tags
```

### 3.2 Progress commits

Commit **at least once every 24 hours** while the run is active. Each commit
message must name the step or sub-goal: `target-selection`,
`literature-synthesis`, `structural-analysis`, `scaffold-design`, `docking`,
`candidate-selection`, `report-drafting`, `self-review`, etc. Longer gaps are
allowed only if `RUN.md` is updated in the same commit to explain why (system
was paused, tool ran for 14 hours, etc.).

**Three consecutive missed 24-hour windows without explanation: disqualified.**

Progress notes live under `systems/<system-name>/progress/NNN-<slug>.md`,
where `NNN` is a three-digit zero-padded counter. Each progress note records
what you tried, what you kept, what you discarded, and why.

### 3.3 Artifact commits

Every output that influences the final report must be committed the moment it
is produced, under `systems/<system-name>/artifacts/`. This includes:

- raw tool outputs (docking poses, structure predictions, design trajectories)
- intermediate analyses (filtered target lists, binding pocket characterizations)
- figures and plots (as PNG or SVG, with the script that made them)
- tool invocation logs (one JSONL file per tool, appending on each call)

Nothing that the report cites may exist only in memory, in a scratch
directory, or in a chat transcript. If the report quotes a number, the commit
that produced that number must be findable in the history.

### 3.4 Hour-168 final commit

Before hour 168, commit and push a tag `<system-name>-final`. This commit must
contain:

- `systems/<system-name>/REPORT.md`: the complete final report, following
  `REPORT_TEMPLATE.md` at the repo root.
- `systems/<system-name>/candidates/candidates.json`: the three candidates in
  the schema defined in §4 below.
- `systems/<system-name>/candidates/<id>/`: one subdirectory per candidate,
  containing its structure file (SDF for small molecules, FASTA for sequences,
  PDB for docked complexes), its predicted properties table, and any figures
  referenced in the report.
- `systems/<system-name>/RUN.md` updated with: actual end timestamp, total
  wall-clock used, number of tool invocations, total commit count, and a
  full tool-invocation ledger (or a link to the JSONL ledger).

Example:

```bash
git add systems/workgraph/
git commit -m "workgraph: final (hour 167:42:09)"
git tag workgraph-final
git push origin main --tags
```

---

## 4. Candidate file schema

`systems/<system-name>/candidates/candidates.json` must be a JSON array of
exactly three objects. Each object:

```json
{
  "id": "C1",
  "modality": "small_molecule | peptide | cyclic_peptide | macrocycle | protac | molecular_glue | engineered_protein | aptamer | mrna | other",
  "name": "candidate-friendly-name",
  "smiles": "CC(=O)Oc1ccccc1C(=O)O",
  "sequence": null,
  "target": {
    "protein": "KRAS G12D",
    "uniprot": "P01116",
    "binding_site": "switch-II pocket | switch-I/II interface | allosteric-novel | other (describe)"
  },
  "mechanism": "single sentence on how this is expected to act against KRAS G12D in PDAC",
  "predicted_activity": {
    "affinity_nM": 42.0,
    "affinity_method": "DiffDock + AutoDock Vina rescoring",
    "confidence": "low | medium | high",
    "notes": "anything the reviewer must know to read these numbers honestly"
  },
  "admet": {
    "molecular_weight": 180.16,
    "logp": 1.2,
    "tpsa": 63.6,
    "qed": 0.72,
    "synthetic_accessibility": 2.1,
    "flags": ["possible hERG", "slight Lipinski violation: MW"]
  },
  "novelty": {
    "closest_known": "MRTX1133",
    "distance_metric": "Tanimoto on Morgan-2 fingerprints",
    "distance_value": 0.31,
    "notes": "scaffold-hop from MRTX1133 with modified warhead; justification in report §4"
  },
  "artifacts": [
    "candidates/C1/structure.sdf",
    "candidates/C1/docked_pose.pdb",
    "candidates/C1/properties.csv",
    "candidates/C1/figure_binding_mode.png"
  ],
  "report_section": "§4.1"
}
```

Fields that do not apply to a modality (e.g. `smiles` for a pure protein
candidate) may be `null`, but every key must be present.

---

## 5. Required report structure

`REPORT.md` must follow `REPORT_TEMPLATE.md` at the repo root. The headings
there are mandatory. In summary, the report must contain:

1. **Executive summary** (≤ 300 words). What you did, the three candidates,
   your one-line verdict on each.
2. **Target rationale.** Why these targets, grounded in cited literature.
   Specific to KRAS G12D in PDAC.
3. **Design methodology.** Reproducible, step-by-step. A reader must be able
   to rerun your pipeline from this section alone. Tool versions, parameters,
   inputs, outputs, decisions.
4. **The three candidates.** For each: identifier, modality, structure,
   binding mode, predicted affinity and selectivity, ADMET flags, figure,
   mechanism against KRAS G12D in PDAC, novelty argument vs prior art.
5. **Predicted binding and activity.** Quantitative, with method and error
   bars. Distinguish prediction from literature precedent.
6. **Honest limitations.** What the predictions do not tell you. What would
   need to be done experimentally. Known failure modes of your tools.
7. **Provenance and audit trail.** A table mapping every claim in the report
   to the commit, artifact file, and tool invocation that produced it. For
   WorkGraph specifically, a link to the browsable computation graph.
8. **Appendix: data and code.** Paths inside the repository to every artifact
   that backs a claim.

Minimum length for the body (§§2-7): 2,000 words. No upper limit. Reports
that skip a section, or that make quantitative claims without the backing
artifact in the repository, will be marked down on auditability.

---

## 6. Evaluation (summary)

All three runs are scored on the same four dimensions, by independent
reviewers, with the GitHub history as the primary evidence. Full rubric at
`EVALUATION.md`.

- **Endurance.** Did the system complete the full pipeline without failing?
- **Quality.** Are the molecules chemically plausible? Do the rationales
  reflect the current literature?
- **Depth.** Surface summary, or actual molecular design with non-trivial
  reasoning?
- **Auditability.** Can a third party trace every conclusion from the commit
  history alone?

---

## 7. Disqualification conditions (summary)

- No valid `REPORT.md` by hour 168, or final commit after hour 168
- Force-push, rewritten history, or backdated commits
- Fewer than three candidates, or more than three
- Candidates that do not parse (invalid SMILES, invalid sequences)
- Fabricated citations or fabricated tool outputs
- Missing required report sections
- Quantitative claims without backing artifacts in the repository

A disqualification ruling is made by the co-founders after the deadline, with
the evidence (all public) published in `meta/rulings.md`.

---

## 8. Now begin

1. Write `systems/<your-system-name>/RUN.md` from the template.
2. Copy this file to `systems/<your-system-name>/prompt.md`.
3. Commit and tag `<system-name>-start`. Push.
4. The clock is running.
