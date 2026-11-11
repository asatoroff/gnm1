# Documentation

This directory holds the documentation this Flutter template expects a real project to fill in. It is organized by concern so product intent, domain rules, implementation decisions, and delivery planning can evolve independently. Every file currently contains placeholder/template content — replace it with your project's actual answers as you make each decision, rather than deleting the structure.

## Documentation map

- [Product vision](vision.md) — what the product is, whom it serves, its boundaries, principles, and success measures.
- [Architecture](architecture.md) — application structure, persistence approach, and offline behavior.
- [Technology stack](tech-stack.md) — the current stack and the rationale for each dependency as it's added.
- [UI design system](ui-design-system.md) — visual direction, interaction principles, reusable components, motion, layouts, and accessibility.
- [Domain model](domain-model.md) — core concepts, vocabulary, state/workflow model, and domain rules.
- [Data model](data-model.md) — application entities, relationships, and (if applicable) the event envelope.
- [External integration](api.md) — the boundary and adapter pattern for any external API this project depends on.
- [Roadmap](roadmap.md) — milestone-based delivery plan, matching the shape used in `.github/milestones.yml`.

## Architecture decision records

- [ADR-001: Use Flutter](adr/adr-001-use-flutter.md)
- [ADR template](adr/adr-template.md) — copy this when a new durable architectural decision needs recording.

## Reading paths

New contributors should start with the [product vision](vision.md), then read [domain model](domain-model.md), [architecture](architecture.md), and [technology stack](tech-stack.md). Designers can start with the [UI design system](ui-design-system.md). Work involving an external service should also consult [external integration](api.md) and [data model](data-model.md).
