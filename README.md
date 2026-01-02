# 🤖 OpenCode Shared Workflows

Ce dépôt centralise la configuration et la logique des agents IA (OpenCode) via **OpenCode Zen** pour l'organisation l-etabli.

Il permet de maintenir une logique unique ("Moteur") et de l'appeler facilement depuis n'importe quel autre projet de l'organisation via des workflows "satellites". La couche Zen permet d'utiliser n'importe quel modèle (Anthropic, Google, etc.) avec une seule clé API.

## 🚀 Installation rapide sur un autre projet

Pour ajouter les workflows OpenCode (Flash, Pro & Opus) sur un projet existant :

1. Assurez-vous d'avoir le secret `OPENCODE_API_KEY` configuré dans le dépôt cible (ou hérité de l'organisation)
2. Placez-vous à la racine du projet cible
3. Lancez cette commande (nécessite [GitHub CLI](https://cli.github.com/)) :

```bash
gh api repos/l-etabli/devtools/contents/setup-opencode-workflows.sh -q .content | base64 -d | bash
```

Cette commande crée automatiquement les 3 workflows dans `.github/workflows/`.

---

## 📖 Installation manuelle (alternative)

Si vous préférez créer les fichiers manuellement, créez les fichiers suivants dans `.github/workflows/` :

<details>
<summary>⚡️ Mode Rapide (Gemini 3 Flash)</summary>

Créez `.github/workflows/oc-gemini-3-flash.yml` :

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
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
```

</details>

<details>
<summary>🧠 Mode Standard (Gemini 3 Pro)</summary>

Créez `.github/workflows/oc-gemini-3-pro.yml` :

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
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
```

</details>

<details>
<summary>💎 Mode Expert (Claude Opus 4.5)</summary>

Créez `.github/workflows/oc-opus-4-5.yml` :

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
    secrets:
      OPENCODE_API_KEY: ${{ secrets.OPENCODE_API_KEY }}
```

</details>

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
