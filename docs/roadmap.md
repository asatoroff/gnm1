# Product roadmap

> Template note: this document mirrors the milestone shape used in `.github/milestones.yml` (`M<track>.<step>`, described in `.github/PROJECT_MANAGEMENT.md`). Replace the placeholder milestones below with your project's actual delivery plan, and keep the two in sync as the roadmap evolves.

The roadmap should protect the product's core boundary stated in [vision](vision.md) — name it here in one sentence so every milestone can be checked against it. Omit dates until early discovery has validated scope, if that fits your delivery style; otherwise state target dates explicitly.

## Version 1 — [name the initial release scope]

### M1.0 — [Discovery/prototype]

- [Milestone goals.]

Exit criteria: [what must be true to consider this milestone done].

### M1.1 — [Technical foundation]

- Bootstrap the Flutter app for the target platforms with strict Dart analysis.
- Establish design tokens, error handling, logging, repositories, and CI.
- [Persistence setup, if decided.]
- [External-adapter setup, if decided — see [external integration](api.md).]

Exit criteria: both platforms launch; automated tests run in CI; [additional criteria].

### M1.2 — [Next milestone]

- [Scope.]

Exit criteria: [criteria].

### M1.3 — [Next milestone]

- [Scope.]

Exit criteria: [criteria].

### M1.4 — Release readiness

- Accessibility and high-contrast/reduced-motion review.
- Performance, crash recovery, offline, and migration testing.
- Privacy policy, data-deletion flow, and third-party service inventory.
- Store assets and beta testing.

### Version 1 feature priorities

**Must:** [non-negotiable scope for a usable first release].

**Should:** [valuable but deferrable without blocking release].

**Could:** [nice-to-have, explicitly not planned for Version 1].

## Version 2 — [name the next major direction]

Describe the next major capability this product is expected to grow into (for example, multi-device sync, accounts, collaboration) at a level of detail appropriate to how validated the idea currently is. Do not commit implementation details this early — name the open questions instead.

## Future ideas

List validated-but-unscheduled ideas here. This section is intentionally unordered and non-committal; promote an item to a numbered milestone only once it has entered the planned delivery sequence, matching the policy in `.github/PROJECT_MANAGEMENT.md`.

## Explicit non-goals

List what this product deliberately will not do, at least for the foreseeable roadmap — this list is as valuable as the roadmap itself for keeping scope honest during triage.

## First technical spikes

If there is technical risk worth resolving before committing to the M1.1+ plan, name the spike and what it validates:

### Spike: [name]

1. ...
2. ...

This validates [the specific risk or unknown].
