# Contributing

Start with `docs/vision.md`, then read the relevant architecture, data-model, and UI guidance for the area you're changing. See `docs/README.md` for the full documentation map. Participation in this project is governed by our [Code of Conduct](CODE_OF_CONDUCT.md).

## Before implementation

1. Search existing issues and discussions.
2. Use the appropriate issue form for non-trivial work.
3. Agree on scope and acceptance criteria before large changes.
4. Create or update an ADR when changing a durable architectural decision.

Issues move from `status: needs-triage` to `status: ready` only when the outcome, boundaries, dependencies, acceptance criteria, priority, area, and milestone are clear.

## Development workflow

- Branch from `develop` and target pull requests at `develop`, not `main`. `main` only receives the deliberate `develop → main` promotion described in `README.md`; do not open feature or fix PRs against it.
- Keep pull requests focused and link the issue they resolve.
- Use the issue-form prefixes `feat:`, `fix:`, and `chore:`; GitHub uses the issue title when suggesting a development branch.
- Prefer branch names such as `feat/123-sign-in-screen`, `fix/124-null-crash`, and `refactor/125-repository-split` when creating branches manually.
- Use Conventional Commit-style PR titles, such as `feat(auth): persist session token`.
- Run `flutter analyze` and `flutter test` before requesting review.
- Add tests for domain rules, reducers or state logic, migrations, and external-data normalization.
- Use fixtures and fakes instead of live network calls in normal automated tests.
- Include screenshots or recordings for visible UI changes.

## Definition of done

Work is done when acceptance criteria pass, tests and analysis pass, affected documentation is current, accessibility and offline behavior are considered, migrations are safe, and the change is reviewable and reversible where appropriate.

## Triage cadence

Maintainers should review Inbox weekly, confirm milestone priorities, split oversized work, close obsolete requests, and keep only accepted work in Ready. Release milestones should be reviewed against the exit criteria in `docs/roadmap.md`.
