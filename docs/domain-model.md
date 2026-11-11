# Domain model

> Template note: this document describes the *shape* a domain-model document should take, not a real domain. Replace each section with your project's actual concepts, vocabulary, and rules, and delete this note once it does.

## Scope

State what this application models, and just as importantly what it deliberately does not model. A clear non-scope statement here prevents scope creep later — name the adjacent problem this project is not trying to solve.

## Core vocabulary

List the domain's key nouns and verbs with short, precise definitions — the terms every contributor and every screen should use consistently. Inconsistent vocabulary between code, UI copy, and documentation is a common source of bugs and confusing reviews.

```text
Term        Definition
----        ----------
<Entity>    ...
<Action>    ...
<State>     ...
```

## State / workflow model

If the domain has a meaningful state machine or workflow (an order moving through statuses, a session progressing through phases, a document moving through review), describe it here: the states, the valid transitions between them, and which transitions are user-triggered versus automatic/derived.

```text
<state>
├── <substate>
└── <substate>
```

Describe what one user-triggered transition entails: does it only change one field, or does it deterministically cascade into other consequences (expiring something, resetting a counter, notifying someone)? Cascading consequences are usually worth modeling explicitly rather than leaving to ad hoc code at each call site.

## Configuration and presets

If the domain supports meaningfully different starting configurations (templates, presets, plans, tiers), describe how a session/entity is configured at creation and which fields are fixed afterward versus adjustable later.

## Extensible attributes

If the domain has an open-ended set of tracked values (custom fields, counters, tags, flags) rather than a fixed schema, describe the common shape those values share (name, value, owner, constraints) and which ones are built in versus user-defined.

## Reminders / scheduled notifications

If the domain needs to prompt the user at the right moment (a due date, a recurring check-in, a threshold being crossed), describe the supported trigger types, how a reminder is created, and what happens when it fires — the app should surface it, not silently resolve it on the user's behalf unless that is an explicit, agreed behavior.

## Time-bound or conditional state

If some state is only valid for a limited time or condition (a temporary status, a promotional price, a hold), describe how expiration is detected: is it deterministic and checked at defined transition points, or does it require an explicit user action to resolve? Prefer deterministic expiration wherever the condition is actually knowable by the system.

## History, recovery, and undo

Describe what must survive an app restart or crash, what the user can undo, and how far back undo needs to reach. This has direct architectural consequences — see [architecture](architecture.md) and any ADR you write about your persistence/event strategy.

## Representative end-to-end flow

Walk through one complete, realistic user flow from start to finish, the way a new contributor would want to read it before touching related code:

1. ...
2. ...
3. ...
