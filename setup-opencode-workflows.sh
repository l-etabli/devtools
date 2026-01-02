#!/bin/bash
set -e

mkdir -p .github/workflows

cat > .github/workflows/oc-gemini-3-flash.yml << 'EOF'
name: OpenCode Gemini 3 Flash

on:
  issue_comment:
    types: [created]

jobs:
  trigger:
    if: contains(github.event.comment.body, 'oc-gemini-3-flash')
    permissions:
      contents: write
      issues: write
      pull-requests: write
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: google/gemini-3-flash
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
EOF

cat > .github/workflows/oc-gemini-3-pro.yml << 'EOF'
name: OpenCode Gemini 3 Pro

on:
  issue_comment:
    types: [created]

jobs:
  trigger:
    if: contains(github.event.comment.body, 'oc-gemini-3-pro')
    permissions:
      contents: write
      issues: write
      pull-requests: write
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: google/gemini-3-pro
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
EOF

cat > .github/workflows/oc-opus-4-5.yml << 'EOF'
name: OpenCode Claude Opus 4.5

on:
  issue_comment:
    types: [created]

jobs:
  trigger:
    if: contains(github.event.comment.body, 'oc-opus-4.5')
    permissions:
      contents: write
      issues: write
      pull-requests: write
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: anthropic/claude-opus-4.5
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
EOF

echo "OpenCode workflows installed successfully!"
