# External integration

> Template note: this document describes the *shape* of documenting a boundary to an external API/service, not a real integration. Replace it with your project's actual external dependency, or delete the sections that don't apply if the project has none yet.

## Role and philosophy

Name the external service this project depends on (if any), and state plainly that it is a reference/upstream source, not the operational database — application-owned data stays in local persistence regardless of what an external service provides.

```text
External service
    ↓
Adapter and local cache
    ↓
Application database
    ↓
Feature code
```

This boundary keeps the app usable during network failures and isolates the rest of the application from the external service's latency, schema, and policy changes. If this is a durable architectural decision, record it as an ADR — see [docs/adr/](adr/).

## Integration boundary

Define the capability boundary as an interface, independent of the concrete HTTP client or response types used to implement it:

```ts
interface ExternalCatalog {
  search(query: string): Promise<SearchResult>;
  getById(id: string): Promise<Record | null>;
  refresh(): Promise<RefreshResult>;
}
```

Screens and domain services should consume normalized application models through this interface, never the raw external response shape. This supports tests without live calls, alternative caching strategies, and swapping the underlying provider later.

## Requests, throttling, and caching

Describe: how search/lookup requests are debounced and cancelled when superseded, what the actual documented rate limits and required headers are (verify against current provider documentation — don't rely on notes taken once at integration time), where central throttling/backoff/retry logic lives (the adapter, not call sites), and what gets cached locally versus fetched fresh.

Cache policy should:

- return usable local results immediately where possible;
- refresh stale data opportunistically when online;
- avoid re-fetching unchanged records;
- keep dependent features functional during failures;
- make storage limits and eviction explicit.

## Stable identity

If the external service's own identifiers can change over time (record migrations, renames, replaced IDs), describe how this project tolerates that without losing user data tied to the old identifier — store the external ID plus enough local context to re-resolve it if needed. Never use a display name as a durable identifier.

## Failure handling and testing requirements

State what a network failure from this service should never be allowed to do (block a core local workflow, corrupt local state) and what failure states the adapter must expose explicitly (offline, throttled, not-found, validation, transient). Tests should use fixtures/fakes for this service's behavior, including error responses, missing fields, and cancellation; normal CI should not depend on live access to the real service.

## Before every release

Review the current version of the external service's terms, rate limits, required attribution, and any usage policy — do not rely indefinitely on assumptions made at initial integration time.
