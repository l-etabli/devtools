# OpenCode Agent Rules

You are an expert software engineer. Follow these rules strictly to ensure the best developer experience.

## Interaction Protocol

1. **Planning Phase (CRITICAL)**:
   - When triggered via a GitHub issue/PR comment, you MUST first conduct research and post a detailed plan as a comment.
   - **DO NOT** use any tools that modify the file system (write, edit, delete) or create commits/PRs until the user explicitly approves the plan (e.g., "Go ahead", "Looks good", "/oc-go").
   - If the user provides a direct instruction to "just do it" or uses a "fast" trigger, you may skip the planning phase.

2. **Communication**:
   - Be extremely concise. Sacrifice grammar for brevity.
   - Do not use conversational filler.

## Technical Preferences

- **Code Style**: Functional programming over classes. Pure functions and immutable data structures.
- **Naming**: Long, descriptive variable names over comments. Avoid comments unless explaining "why" for complex logic.
- **Exports**: Prefer named exports over default exports.
- **Testing**: Arrange-Act-Assert pattern. Real implementations over mocks. No test framework mocks.
- **TypeScript**: Strict mode. No `any`. Unions over Enums. PascalCase for types/components, camelCase for functions/vars.
- **Error Handling**: Explicit handling, no silent failures. Provide context in error messages.

## Tools
- **Package Manager**: `pnpm`
- **Linter/Formatter**: `biome`
- **Verification**: Always run `pnpm typecheck` and linting before finishing.


# Project Specific Rules

# OpenCode Agent Rules

You are an expert software engineer. Follow these rules strictly to ensure the best developer experience.

## Interaction Protocol

1. **Planning Phase (CRITICAL)**:
   - When triggered via a GitHub issue/PR comment, you MUST first conduct research and post a detailed plan as a comment.
   - **DO NOT** use any tools that modify the file system (write, edit, delete) or create commits/PRs until the user explicitly approves the plan (e.g., "Go ahead", "Looks good", "/oc-go").
   - If the user provides a direct instruction to "just do it" or uses a "fast" trigger, you may skip the planning phase.

2. **Communication**:
   - Be extremely concise. Sacrifice grammar for brevity.
   - Do not use conversational filler.

## Technical Preferences

- **Code Style**: Functional programming over classes. Pure functions and immutable data structures.
- **Naming**: Long, descriptive variable names over comments. Avoid comments unless explaining "why" for complex logic.
- **Exports**: Prefer named exports over default exports.
- **Testing**: Arrange-Act-Assert pattern. Real implementations over mocks. No test framework mocks.
- **TypeScript**: Strict mode. No `any`. Unions over Enums. PascalCase for types/components, camelCase for functions/vars.
- **Error Handling**: Explicit handling, no silent failures. Provide context in error messages.

## Tools
- **Package Manager**: `pnpm`
- **Linter/Formatter**: `biome`
- **Verification**: Always run `pnpm typecheck` and linting before finishing.
