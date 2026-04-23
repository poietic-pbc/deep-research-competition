# WorkGraph run

This is WorkGraph's arena. All WorkGraph work during the competition lives
under this directory.

## What WorkGraph is

WorkGraph is an open-source multi-agent coordination graph in which AI
agents and humans share a single task DAG. Agents claim ready tasks, execute
them in isolated git worktrees, commit their outputs, and update the graph.
Humans participate as first-class actors. The full process is an auditable
computation graph.

Repository: https://github.com/graphwork/workgraph
Docs: https://graphwork.github.io/

## Before launch

From the repo root:

```bash
cd systems/workgraph
cp ../../prompt.md ./prompt.md
shasum -a 256 ./prompt.md  # record in RUN.md
$EDITOR RUN.md              # fill in placeholders
```

## Launch

```bash
# initialize a workgraph in this subdirectory
wg init

# register the specialist agents
wg actor add cancer-biologist    --kind agent --model claude-opus-4-7
wg actor add structural-biologist --kind agent --model claude-opus-4-7
wg actor add medicinal-chemist    --kind agent --model claude-opus-4-7
wg actor add molecular-designer   --kind agent --model claude-opus-4-7
wg actor add critic               --kind agent --model claude-opus-4-7

# register the humans
wg actor add erik  --kind human --email erik.garrison@gmail.com
wg actor add luca  --kind human --email lucapinello@gmail.com

# seed the top-level task with the prompt
wg task add "deep-research-competition" \
  --spec prompt.md \
  --assignee-any cancer-biologist,structural-biologist,medicinal-chemist,molecular-designer

# start the service daemon
wg serve --commit-on-complete --push-remote origin
```

## During the run

WorkGraph commits each completed task as a discrete commit under
`systems/workgraph/`. The human operator's job is mostly to watch the graph
and intervene only when the graph reports `blocked` or `failed`.

To watch progress:

```bash
wg tail           # live-streaming log of graph changes
wg graph --html   # renders the current graph to computation-graph.html
```

## Hour-168 deliverable specifics

In addition to the universal `REPORT.md` and `candidates/` requirements,
WorkGraph must produce:

- `systems/workgraph/computation-graph.html`: the final browsable graph.
- `systems/workgraph/.workgraph/graph.jsonl`: the raw jsonl log of the run
  (already committed by the service daemon).
- `systems/workgraph/progress/actor-log.md`: a summary of which actor
  handled which task, with edges.

These are the artifacts that make the auditability dimension real.
