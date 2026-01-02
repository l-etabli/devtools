#!/bin/bash
set -e

mkdir -p .github/workflows

cat > .github/workflows/opencode.yml << 'EOF'
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
EOF

echo "OpenCode workflow installed successfully!"
echo "Available triggers: /oc-gemini-3-flash, /oc-gemini-3-pro, /oc-opus-4.5"
