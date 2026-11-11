# Data model

> Template note: this document shows the *shape* of a data-model document — an entity-relationship overview plus, if relevant, an event-envelope pattern — not real entities. Replace it with your project's actual schema.

## Model boundaries

State which data is application-owned (persisted locally, source of truth) versus normalized from an external source (cached, refreshable, never the operational database). State whether entities use conventional CRUD or event-sourced state, and why, per [architecture](architecture.md). Identifiers should be stable values (UUIDs or similar) unless an upstream identifier from an external system is explicitly named as such.

## Relationships

Sketch the entity relationships as a simple diagram, for example:

```text
<Entity A> 1 ── * <Entity B> * ── 1 <Entity C>

<Aggregate> 1 ── * <ChildEntity>
```

## Entities

For each entity, list its fields with a one-line note on anything non-obvious (nullability, derivation, stability):

```text
<EntityName>
- id
- ...
- createdAt
- updatedAt
```

Repeat for each entity. Note explicitly which fields are materialized/derived (kept for query speed) versus authoritative, and how the two are kept consistent.

## Event envelope (if using event-sourced state)

If part of this project's state is event-sourced, describe the event envelope shape once and reuse it for every event type:

```ts
type DomainEvent = {
  id: string;
  aggregateId: string;
  actorId?: string;
  sequence?: number;
  occurredAt: string;
  type: string;
  payload: unknown;
  schemaVersion: number;
};
```

List the actual event types your domain emits:

```text
<ENTITY>_CREATED
<ENTITY>_UPDATED
<ENTITY>_DELETED
```

State the undo/audit strategy: are corrections represented as new compensating events (preserving history) or can events be deleted? Prefer preserving history unless there's a specific reason not to.

## Cached external records (if applicable)

If this project caches normalized records from an external API, describe what's stored (the fields the app actually needs, plus fetch/update timestamps) and link to [external integration](api.md) for the adapter boundary. The UI should never persist or consume raw external-API response payloads directly.

## Storage and integrity rules

- Persist related state changes transactionally where they must remain consistent.
- Foreign keys should prevent orphaned records for anything owned by a parent aggregate.
- Define what user-initiated deletion actually removes, and whether it's immediate or soft.
- Migrations must cover schema versions, and event payload versions if applicable.
- Store timestamps in UTC; format them for display in the UI layer only.
