# OpenCode Shared Workflows

Centralized AI agent (OpenCode) configuration for l-etabli organization.

Single reusable workflow that handles all models. Add new models in one place - all repos get them automatically.

## Quick Install

Requires `OPENCODE_API_KEY` secret in target repo (or org-level).

```bash
gh api repos/l-etabli/devtools/contents/setup-opencode-workflows.sh -q .content | base64 -d | bash
```

Creates `.github/workflows/opencode.yml` - a single stable workflow that never needs updating.

## Manual Install

Create `.github/workflows/opencode.yml`:

```yaml
name: OpenCode

on:
  issue_comment:
    types: [created]

jobs:
  run:
    if: contains(github.event.comment.body, '/oc-')
    permissions:
      contents: write
      issues: write
      pull-requests: write
      id-token: write
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      comment: ${{ github.event.comment.body }}
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
```

## Usage

Comment on any Issue or PR with a trigger keyword:

| Trigger | Model | Use Case |
| :--- | :--- | :--- |
| `/oc-gemini-3-flash` | Gemini 3 Flash | Quick tasks, docs, typos |
| `/oc-gemini-3-pro` | Gemini 3 Pro | Standard features, daily coding |
| `/oc-opus-4-5` | Claude Opus 4.5 | Complex architecture, deep reasoning |

### Examples

```
/oc-gemini-3-flash Add error handling to this function
/oc-gemini-3-pro Write tests for the auth module
/oc-opus-4-5 Refactor this service using the Repository pattern
```

## Adding a New Model

Edit `.github/workflows/opencode-logic.yml` in this repo only:

```bash
# In the "Parse model from comment" step, add:
elif [[ "$COMMENT" == *"/oc-new-model"* ]]; then
  MODEL="provider/model-name"
```

All repos using this workflow will automatically have access to the new model.

## Architecture

```
Your Repo                          devtools repo
┌─────────────────┐               ┌─────────────────────────┐
│ opencode.yml    │──────────────▶│ opencode-logic.yml      │
│ (stable, never  │   passes      │ - parses trigger        │
│  changes)       │   comment     │ - maps to model         │
└─────────────────┘               │ - runs OpenCode         │
                                  └─────────────────────────┘
```

## Maintenance

All logic lives in `opencode-logic.yml`. Changes here apply to all repos immediately.
