#!/bin/bash
set -e

mkdir -p .github/workflows

cat > .github/workflows/opencode.yml << 'EOF'
name: OpenCode

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]

jobs:
  triage:
    if: contains(github.event.comment.body, '/oc-')
    runs-on: ubuntu-latest
    outputs:
      mode: ${{ steps.detect.outputs.mode }}
    steps:
      - id: detect
        run: |
          COMMENT="${{ github.event.comment.body }}"
          if [[ "$COMMENT" == *"@l-etabli/oc-implement"* ]]; then
            echo "mode=implement" >> $GITHUB_OUTPUT
          else
            echo "mode=plan" >> $GITHUB_OUTPUT
          fi

  plan:
    needs: triage
    if: needs.triage.outputs.mode == 'plan'
    permissions:
      contents: read
      issues: write
      pull-requests: write
      id-token: write
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      comment: ${{ github.event.comment.body }}
      prompt: |
        Review this issue/comment. Analyze the codebase and provide a detailed plan.
        Do NOT create branches or PRs - only respond with a comment explaining your analysis and proposed solution.
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}

  implement:
    needs: triage
    if: needs.triage.outputs.mode == 'implement'
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
echo "Available triggers: /oc-gemini-3-flash, /oc-gemini-3-pro, /oc-opus-4-5"
