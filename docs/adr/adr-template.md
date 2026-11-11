# ADR-NNN: Short, descriptive title of the decision

## Status

Proposed | Accepted | Superseded by [ADR-NNN](adr-NNN-title.md) | Deprecated

## Context

What problem or forcing function made a decision necessary? Describe the situation, constraints, and any options that were considered, factually and without already arguing for the outcome. A future reader who was not in the discussion should understand why this needed a decision at all.

## Decision

State the decision in one or two sentences, then explain it. Be concrete: name the technology, pattern, or boundary being adopted, not just the problem it solves.

## Consequences

What becomes easier or harder as a result? List the direct effects, including on other parts of the system, tooling, migration effort, and team skills. Include trade-offs and downsides honestly, not just benefits.

---

Guidance for writing ADRs in this project:

- One ADR per durable architectural decision: framework/platform choices, persistence strategy, state-management approach, external-service boundaries, and similar decisions that are costly to reverse.
- Do not write an ADR for routine implementation details, naming choices, or anything easily changed in a single PR.
- Number ADRs sequentially (`adr-001-...`, `adr-002-...`) and never reuse or renumber an existing number, even if it is later superseded.
- Keep the status current. When a decision is replaced, mark the old ADR "Superseded by" and link to the new one; do not delete or silently rewrite it.
- Reference the relevant ADR from `docs/architecture.md`, `docs/data-model.md`, or `docs/tech-stack.md` wherever the decision shapes that document.
