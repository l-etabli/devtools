# Contributing to devtools

Welcome! This repository centralizes AI agent configurations for the `l-etabli` organization.

## Adding a New Model

To add a new model, you need to modify `.github/workflows/opencode-logic.yml`.

1.  **Find the "Parse model from comment" step.**
2.  **Add a new `elif` block** for your model trigger.
    ```yaml
    elif [[ "$COMMENT" == *"/oc-new-model"* ]]; then
      MODEL="provider/model-name"
    ```
3.  **Update the error message** to include your new trigger.
4.  **Update `README.md`** and `setup-opencode-workflows.sh` to include the new trigger in the documentation.

## Testing Your Changes

You can test your changes by commenting on an issue in this repository using the new trigger. Since this repo uses its own workflow, it will immediately use the updated logic.

## Linting

We use `actionlint` for workflows and `shellcheck` for scripts. Please ensure your changes pass these checks.
