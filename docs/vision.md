# Product vision

> Template note: every section below is a placeholder shape for a real product-vision document. Replace the bracketed guidance with your project's actual answers before relying on this document, and delete this note once it does.

## Executive summary

In two or three sentences: what does this application do, for whom, on which platforms, and what is the smallest version of it that is genuinely useful? State the offline/online, account/no-account, and single-device/multi-device posture up front — these choices ripple into architecture, persistence, and privacy decisions throughout the rest of the documentation.

> [One sentence framing the product's core value proposition, phrased as a memorable positioning statement.]

## Product vision

Describe the longer-term direction in a few sentences: what should this product become if it succeeds, beyond its first release? Name the comparable products or experiences that inform the vision, and the ones it deliberately does not want to resemble.

The product should reliably answer a short list of questions a user actually has in the moment. List them:

- ...?
- ...?
- ...?

State explicitly what the product does not attempt to be an authority on — the boundary that keeps scope honest as features get proposed.

## Product positioning

State the one-line positioning, then contrast it with the "naive" version of this product (the version without the specific insight this product is built around):

> [One-line positioning statement.]

List what this product is explicitly **not**, at least for its first release:

- not a ...;
- not a ...;
- not a ...;

## Target users

### Primary

Describe the primary user segment: their context, current pain, and what "better" looks like for them.

### Secondary

Describe secondary segments this product should still serve well, even if features are not designed around them first.

### Not initially optimized for

Name the user segments this product is deliberately not optimizing for in its first release, and why — this prevents feature requests from those segments from silently expanding scope.

## Product philosophy

State the guiding philosophy in a sentence or two: what kind of friction the app removes, and what it deliberately asks the user to provide because it cannot be inferred.

Describe the account/data posture: does the app work without an account? What stays local by default? What is the policy on analytics, crash reporting, and third-party services — and what must be documented before anything is enabled?

## Design principles

List 4-6 named design principles, each with one or two sentences explaining what it means in practice. Examples of the *shape* a principle takes (replace with your own):

### [Principle name]

[What this principle means and one concrete example of it in practice.]

### [Principle name]

[What this principle means and one concrete example of it in practice.]

## Product risks and mitigations

List the known risks to the product succeeding — not implementation risks, product risks (wrong scope, wrong audience, dependency risk, over-complexity) — each with a mitigation:

- **[Risk name]:** [mitigation].
- **[Risk name]:** [mitigation].

## Success metrics

List the metrics that would tell you whether the product is actually reducing friction for its users, not just shipping features:

- ...;
- ...;
- ...;

State the single central question that success ultimately answers:

> [The one question that matters most, phrased memorably.]
