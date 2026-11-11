# Application architecture

> Template note: this document describes a generic layered/feature-driven Flutter architecture shape. Adopt, adjust, or replace it based on your project's actual needs, and record the real decision in an ADR once made — see [docs/adr/](adr/).

## Architectural overview

Describe your application's high-level data/control flow as a diagram, for example:

```text
Presentation
    ↓
Application (use cases / commands)
    ↓
Domain (entities, policies, business rules)
    ↓
Data (repositories, local persistence, external adapters)
```

State the core architectural choice this project makes and why: is state derived from events (useful when undo, recovery, audit history, or future synchronization matter) or does it use conventional CRUD (simpler, sufficient for most data that doesn't need history)? Different areas of one app can legitimately make different choices — state which domains use which approach. Record this as an ADR if it's a durable decision (see [ADR-001](adr/adr-001-use-flutter.md) for the shape an ADR takes).

## Layered, feature-driven structure

```text
lib/
  app/
  core/
  design/
  shared/
  features/
    <feature>/
```

Each feature is divided where useful into:

```text
presentation/
application/
domain/
data/
```

- **Presentation** contains screens, widgets, and UI adaptation.
- **Application** coordinates use cases and commands.
- **Domain** contains framework-independent entities, policies, and business rules.
- **Data** implements repositories, persistence mappings, and external adapters.

Domain code should not depend on Flutter widgets or on any specific state-management, persistence, or networking package. Whatever dependency-injection/state-management approach the project adopts should coordinate dependencies and application state, not own domain rules.

## Core workflow engine

If a feature has non-trivial rules for validating and applying changes to its state, describe the engine responsible for it here: what validates a command, what it emits (events, an updated entity, an error), and what applies that output to persisted state. Name the real types once they exist, for example:

```text
<Engine>
    ↓
<Session/Aggregate>
    ↓
<State>
    ↓
UI
```

If the domain has a meaningful internal state machine, document the states and transitions in [domain model](domain-model.md) and link to it from here rather than duplicating it.

## Commands, events, and undo

If this project uses event-sourced state for some or all of its domains: describe what becomes an event, whether a single command can emit multiple events, how undo is represented (a compensating event, not a destructive rewrite of history), and how event schemas are versioned for migrations. See [data model](data-model.md) for the event envelope shape.

If a domain uses conventional CRUD instead, state that plainly here so future contributors don't assume event sourcing applies uniformly.

## Persistence and recovery

Name the actual local persistence technology and describe the save/recovery contract: what is guaranteed to survive process termination, and by when (after every meaningful action, on a timer, on backgrounding)?

```text
1. Validate the command.
2. Persist the resulting state change.
3. Update or periodically create a snapshot, if using event sourcing.
4. Publish the derived state to the UI.
```

Describe what happens on launch: does the app resume the last state automatically, and if so, from what (a snapshot plus subsequent events, or just the latest row)? What must be tested to trust this (migrations, restart-recovery, corrupted-state handling)?

## Repository pattern

Application and domain layers should depend on repository interfaces, not directly on the persistence technology's types or a specific HTTP client's response types. Name the real repository boundaries once they exist (for example, a settings repository, a user-data repository, a specific external-service repository) and keep failure/offline behavior explicit in their interfaces.

## Networking and offline support

Describe what, if anything, requires a backend or external API, and how the app behaves when that dependency is unavailable — a live game/session should never be blocked by a network failure if it doesn't strictly need the network to continue. State how requests are debounced, retried, and cached, and where that logic is centralized (an adapter, not scattered across call sites).

```text
External service
    ↓
Adapter and local cache
    ↓
Application database
    ↓
Feature code
```

## Testing architecture

Describe what's covered by which kind of test: domain policies and rules (unit), persistence and migrations (integration), external-adapter behavior against fixtures/fakes rather than live services, widget/golden tests for critical UI states, and end-to-end tests for the flows that matter most. Fakes implementing repository interfaces should let domain tests run without live network access.
