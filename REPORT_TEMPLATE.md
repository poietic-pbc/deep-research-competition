# REPORT (TEMPLATE)

Copy this file to `systems/<system-name>/REPORT.md` and fill in every section.
Headings are mandatory and must appear in this order. Minimum length for the
body (§§ 2-7): 2,000 words. No upper limit.

---

## 1. Executive summary

One to three paragraphs, at most 300 words total. State:

- the target(s) you chose, in one line
- the three candidates, each in one line (id, modality, mechanism)
- your one-line verdict per candidate: "plausible starting point",
  "speculative, needs validation", "high-risk but novel", etc.

## 2. Target rationale

Why these targets for KRAS G12D in PDAC specifically. Cite primary
literature (PMID or DOI) for every nontrivial claim. Do not invent
citations. Discuss:

- what is known about KRAS G12D structurally and functionally
- what differentiates G12D from G12C, G12V, and wild-type
- how the PDAC microenvironment constrains target selection (stroma,
  immune exclusion, delivery)
- why the targets you picked are tractable with the tools available

## 3. Design methodology

Step by step, how you went from target to candidate. A reader must be able
to re-run your pipeline from this section alone. Include:

- tools used, with exact versions and parameters
- inputs fed to each tool (path in the repository)
- outputs from each tool (path in the repository)
- decisions made at each step: what was kept, what was discarded, why
- any operator interventions (should be minimal)

Cross-reference specific commits where each step is captured. Example:
"Initial scaffold generated from RFdiffusion run, commit `a1b2c3d`, output
in `artifacts/rfdiffusion/run-04/`."

## 4. The three candidates

For each of the three candidates, a subsection with:

### 4.X <candidate-id>: <short name>

- **Modality.** (small molecule / peptide / degrader / protein / etc.)
- **Structure.** SMILES for small molecules, sequence for proteins or
  peptides, SMILES with explicit warhead and E3 ligand for degraders.
  Reference the structure file in `candidates/<id>/structure.sdf` or
  `.fasta`.
- **Intended binding site and binding mode.** Which pocket, which residues.
  Reference the docked pose or binding surface figure.
- **Predicted affinity and selectivity.** Numbers, the method that produced
  them, and the method's known error bars. Selectivity against wild-type
  KRAS and other RAS family members (NRAS, HRAS).
- **ADMET and developability flags.** Molecular weight, logP, TPSA, QED,
  synthetic accessibility. Known liabilities (hERG, PAINS, Lipinski
  violations).
- **Figure.** One figure per candidate: docked pose, binding surface, or
  structural model. Reference by path.
- **Mechanism of action against KRAS G12D in PDAC.** One to two paragraphs.
  Be specific. "Allosteric inhibitor" is not an answer; "binds the
  switch-II pocket in the GDP state and locks RAS in an inactive
  conformation, analogous to MRTX1133 but with a modified warhead that
  preferentially engages the G12D aspartate" is an answer.
- **Novelty argument.** Tanimoto distance to the closest known compound
  (for small molecules), sequence identity (for proteins or peptides), or
  equivalent. What makes this candidate worth pursuing over the known art.

## 5. Predicted binding and activity

A single section summarizing the quantitative predictions across all three
candidates, with method and error bars. Distinguish:

- predicted affinity from docking or structure prediction (with the tool's
  published error profile)
- predicted activity from cell-line similarity models, if used
- literature precedent (e.g. "MRTX1133 IC50 reported at X nM, PMID ...")

Include a comparison table. Be honest about confidence. Docking scores are
not binding affinities.

## 6. Honest limitations

What the predictions do not tell you. Candidate topics:

- known failure modes of the tools you used (e.g. DiffDock's performance
  on protein-protein interfaces, AlphaFold's uncertainty on unseen
  sequences)
- assumptions baked into your target selection that may be wrong
- things you could not evaluate (selectivity against 500 kinases, in-cell
  permeability, in-vivo PK)
- what would need to be done experimentally before any of these candidates
  could be taken seriously: synthesis feasibility, biochemical assay,
  cellular assay, xenograft

## 7. Provenance and audit trail

A table with one row per claim in this report (or at least one row per
non-trivial claim in sections 4 and 5). Columns:

| claim | evidence (file path) | tool | commit | confidence |
|-------|----------------------|------|--------|------------|

For WorkGraph only: a link to the browsable computation graph, rendered as
`artifacts/computation-graph.html`, and the commit it was generated from.

## 8. Appendix: data and code

An enumeration of paths inside this repository. At minimum:

- `candidates/candidates.json`
- `candidates/<id>/` for each candidate
- `progress/` index (list of progress note files in order)
- `artifacts/` index (list of artifact subdirectories and what each contains)
- `RUN.md` (operator's log)
- `prompt.md` (frozen copy of the canonical prompt)

If you used code beyond the listed tools, commit it to `artifacts/code/` and
reference it here.
