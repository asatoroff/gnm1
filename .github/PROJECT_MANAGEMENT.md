# Project management playbook

The canonical delivery model comes from `docs/roadmap.md`. GitHub configuration is stored as code in this directory and synchronized with `scripts/bootstrap-github.sh`.

## One-time setup

From the repository root, authenticate a maintainer account with the project scope and run:

```sh
gh auth login -h github.com
gh auth refresh -s project
bash scripts/bootstrap-github.sh
```

Use `--dry-run` to preview changes. The script is idempotent: it enables Discussions, sets write-level default workflow permissions and allows Actions to create pull requests (both required by `release-please`, see below), creates `develop` from `main`'s current tip if it doesn't exist yet and makes it the default branch, synchronizes a ruleset covering both `main` and `develop`, updates matching labels and milestones, reuses a project with the configured title, links it to the repository, and adds missing project fields. It requires Bash, Git, and the GitHub CLI, so it works on Linux, macOS, and Windows environments such as Git Bash or WSL.

## Branching model and ruleset

`develop` is the default branch and the target for ordinary feature/fix pull requests. `main` only receives commits through a deliberate `develop → main` promotion pull request (`mise run release:promote`, see `scripts/promote-release.sh`) — that promotion is the only thing that should ever update `main`, and merging it is what triggers a release (see below).

The synchronized ruleset targets both `main` and `develop` identically and blocks force-pushes and branch deletion on each. It requires a pull request before merging, but sets the required approving-review count to zero so a single maintainer can still merge their own work — raise that count once the project has more than one active reviewer. It also requires the CI quality job (`Format, analyze, and test`) and the PR-title check (`conventional-title`) to pass before merging, kept in sync with the job names in `.github/workflows/ci.yml` and `.github/workflows/pr-title.yml`.

GitHub's ruleset system has no rule type that restricts which branch a pull request may come from, so "only `develop` merges into `main`" cannot be technically enforced — it is a convention documented here and in `CONTRIBUTING.md`/`AGENTS.md`, backed only by the same required-checks ruleset as every other PR.

## Releases

`.github/workflows/release-please.yml` runs [release-please](https://github.com/googleapis/release-please) on every push to `main` — i.e., only after a `develop → main` promotion is merged, never on ordinary feature/fix merges into `develop`. It reads Conventional Commit history and maintains an up-to-date "Release PR" that bumps the `version:` field in `pubspec.yaml` and writes `CHANGELOG.md`. Only `feat`, `fix`, and commits with a `!`/`BREAKING CHANGE` footer affect the version and appear in the changelog; `chore`/`docs`/`refactor`-only history produces no Release PR. Merging the Release PR tags a GitHub Release at that version. release-please does not build, publish, or deploy anything by itself — wire a separate workflow (triggered on the GitHub Release) if you need that, and gate it with a [GitHub Environment requiring manual approval](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments) before it does anything irreversible. Configuration lives in `release-please-config.json` and `.release-please-manifest.json` at the repository root — do not hand-edit the manifest's version field; let release-please manage it.

## Milestone ordering

Delivery milestones use `M<track>.<step>` prefixes. The first number groups a coherent delivery track and the second number states the sequence within it. For example, `M1.2` follows `M1.1`, while `M2.0` begins the next track. These identifiers describe delivery order, not application versions; release versions and Git tags are managed separately.

The future backlog is intentionally unnumbered because it is neither ordered nor committed. Assign an item to a numbered milestone only after it has entered the planned delivery sequence.

After bootstrapping, use `.github/project.yml` to create the saved Roadmap, Delivery board, Priorities, and Backlog views and enable the listed built-in project workflows. GitHub currently manages these view/workflow details most reliably in the project UI.

## Issue readiness

An issue may move to Ready when it has one type, one priority, at least one area, an owner or explicit pickup path, a numbered milestone (or the unordered future backlog), testable acceptance criteria, known dependencies, and no unresolved product-boundary question.

## Operating cadence

- Weekly triage: classify Inbox, request missing information, remove duplicates, and reject out-of-scope work.
- Weekly delivery review: inspect blocked and in-progress work, limit work in progress, and update risks.
- Milestone review: assess exit criteria from `docs/roadmap.md`, not ticket count alone.
- Release review: verify accessibility, offline/recovery, privacy, migrations, attribution, and platform readiness.

## Estimation and priority

Effort is relative: XS is a few hours, S is roughly a day, M is several days, L should usually be split, and XL requires decomposition before Ready. Priority reflects impact and urgency: Critical is reserved for security, data loss, release blockers, or unusable core flows.
