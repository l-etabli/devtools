# 🤖 OpenCode Shared Workflows

Ce dépôt centralise la configuration et la logique des agents IA (OpenCode) pour l'organisation l-etabli.

Il permet de maintenir une logique unique ("Moteur") et de l'appeler facilement depuis n'importe quel autre projet de l'organisation via des workflows "satellites".

## 🚀 Installation dans un nouveau projet

Pour activer l'IA sur un autre dépôt de l'organisation (ex: mon-app, mon-api), suivez ces deux étapes.

### 1. Pré-requis (Secrets)

Assurez-vous que les secrets suivants sont configurés dans le dépôt (ou hérités de l'organisation) :

- `GOOGLE_API_KEY`
- `ANTHROPIC_API_KEY`

### 2. Ajouter les Déclencheurs

Créez les fichiers suivants dans le dossier `.github/workflows/` de votre projet. Ils font le pont vers ce dépôt central.

#### ⚡️ Mode Rapide (Gemini 3 Flash)

Créez `.github/workflows/oc-flash.yml` :

```yaml
name: OpenCode (Gemini 3 Flash)
on:
  issue_comment:
    types: [created]
jobs:
  call-flash:
    if: contains(github.event.comment.body, 'oc-gemini-3-flash')
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: google/gemini-3-flash
    secrets: inherit
```

#### 🧠 Mode Standard (Gemini 3 Pro)

Créez `.github/workflows/oc-pro.yml` :

```yaml
name: OpenCode (Gemini 3 Pro)
on:
  issue_comment:
    types: [created]
jobs:
  call-pro:
    if: contains(github.event.comment.body, 'oc-gemini-3-pro')
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: google/gemini-3-pro
    secrets: inherit
```

#### 💎 Mode Expert (Claude Opus 4.5)

Créez `.github/workflows/oc-opus.yml` :

```yaml
name: OpenCode (Opus 4.5)
on:
  issue_comment:
    types: [created]
jobs:
  call-opus:
    if: contains(github.event.comment.body, 'oc-opus-4.5')
    uses: l-etabli/devtools/.github/workflows/opencode-logic.yml@main
    with:
      model: anthropic/claude-opus-4.5
    secrets: inherit
```

## 🎮 Comment utiliser l'IA ?

Une fois installé, allez dans n'importe quelle Issue ou Pull Request et mentionnez l'équipe correspondante. Utilisez l'autocomplétion GitHub (`@...`) pour choisir votre modèle.

| Commande (Autocomplétion) | Modèle | Cas d'usage |
| :--- | :--- | :--- |
| `@l-etabli/oc-gemini-3-flash` | Gemini 3 Flash | Docs, Typos, Tests simples. Rapide et peu coûteux. |
| `@l-etabli/oc-gemini-3-pro` | Gemini 3 Pro | Features standard. Le bon équilibre pour le code quotidien. |
| `@l-etabli/oc-opus-4.5` | Claude Opus 4.5 | Architecture & Refacto. Pour les tâches complexes nécessitant un raisonnement profond. |

### Exemples de Prompts

- **Pour corriger une fonction :** `@l-etabli/oc-gemini-3-flash Peux-tu ajouter une gestion d'erreur try/catch autour de cet appel API ?`
- **Pour générer de la documentation :** `@l-etabli/oc-gemini-3-pro Écris la JSDoc pour toutes les fonctions de ce fichier, en expliquant les paramètres.`
- **Pour une refonte d'architecture :** `@l-etabli/oc-opus-4.5 Analyse la structure actuelle du dossier /services. Propose une refonte utilisant le pattern Repository pour découpler la base de données.`

## 🛠 Maintenance

Toute la logique d'exécution se trouve dans le fichier `.github/workflows/opencode-logic.yml` de ce dépôt. En modifiant ce fichier, tous les projets de l'organisation utiliseront immédiatement la nouvelle version.
