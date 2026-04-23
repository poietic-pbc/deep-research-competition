#!/usr/bin/env bash
# Bootstrap the public GitHub repository for the Poietic deep research
# competition. Run this ONCE, from the deep-research-competition/ directory.
#
# Prereqs:
#   - gh CLI installed and authenticated (gh auth status)
#   - git configured with your identity (git config user.name / user.email)
#   - the auth'd account has permission to create repos under $ORG
#
# Override the org and repo name by exporting ORG / REPO before running.

set -euo pipefail

ORG="${ORG:-poietic-pbc}"
REPO="${REPO:-deep-research-competition}"
VISIBILITY="${VISIBILITY:-public}"

# Sanity checks -------------------------------------------------------------

if ! command -v gh >/dev/null; then
  echo "error: gh CLI not found. Install from https://cli.github.com/" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "error: gh is not authenticated. Run: gh auth login" >&2
  exit 1
fi

if [ ! -f prompt.md ] || [ ! -f README.md ]; then
  echo "error: run this from the deep-research-competition/ directory." >&2
  exit 1
fi

if gh repo view "$ORG/$REPO" >/dev/null 2>&1; then
  echo "error: $ORG/$REPO already exists. Aborting so nothing is overwritten." >&2
  exit 1
fi

# Check repo-creation permission in the org
if ! gh api "orgs/$ORG" >/dev/null 2>&1; then
  echo "error: authenticated user cannot see org $ORG." >&2
  echo "       check that you are a member and the token has read:org." >&2
  exit 1
fi

# Initialize local repo if needed -------------------------------------------

if [ ! -d .git ]; then
  git init -q -b main
  git add .
  git commit -q -m "bootstrap: deep research competition scaffold"
fi

# Create the public repo ----------------------------------------------------

echo "creating $ORG/$REPO ($VISIBILITY)..."
gh repo create "$ORG/$REPO" \
  --"$VISIBILITY" \
  --source=. \
  --remote=origin \
  --description="Poietic deep research competition: WorkGraph vs Claude Code vs Codex on KRAS G12D drug discovery. Full audit trail, public." \
  --push

# Post-creation setup -------------------------------------------------------

echo "pinning main as default branch..."
gh api -X PATCH "repos/$ORG/$REPO" -f default_branch=main >/dev/null

echo "enabling issues..."
gh api -X PATCH "repos/$ORG/$REPO" -F has_issues=true >/dev/null

echo "protecting main from force-pushes and history rewrites..."
# Protect against rewrites. Admins can still bypass in emergencies.
gh api -X PUT "repos/$ORG/$REPO/branches/main/protection" \
  -F required_status_checks= \
  -F enforce_admins=false \
  -F required_pull_request_reviews= \
  -F restrictions= \
  -F allow_force_pushes=false \
  -F allow_deletions=false \
  >/dev/null || echo "warning: branch protection call failed; set it manually in Settings > Branches."

echo
echo "done."
echo "  repo:  https://github.com/$ORG/$REPO"
echo "  clone: gh repo clone $ORG/$REPO"
echo
echo "next: on the machine where you will run the systems,"
echo "  gh repo clone $ORG/$REPO"
echo "  cd $REPO"
echo "  \$EDITOR OPERATOR.md"
