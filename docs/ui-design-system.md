# UI design system

> Template note: this document describes the *shape* a design-system document should take. Replace the visual direction, tokens, and component list with your project's actual decisions.

## Experience goals

State the intended feel of the product in a sentence or two, and name 1-3 comparable products it takes visual/interaction inspiration from — while being explicit that the product should not simply imitate their interfaces.

## Interaction principles

List the interaction principles that should hold across the whole app, for example:

- [Principle, e.g. "put one contextual primary action on the main screen".]
- Make undo visible after every meaningful action.
- Prefer deterministic automation over repeated manual bookkeeping.
- Provide immediate visual and optional haptic feedback.
- Make destructive or high-impact actions confirmable or immediately undoable.

## Foundations

### Color

Define semantic color tokens rather than hard-coding widget colors — positive/negative, warning, focus, disabled, and any brand-specific emphasis tokens. Color must never be the only carrier of meaning; pair it with text, iconography, shape, or position. Provide a high-contrast variant.

### Typography

Define the type scale: which face(s) are used for headings versus body/values, and which values (if any) need tabular/stable numerals so they don't visually jitter as they change.

### Spacing and layout

Define a documented spacing scale and consistent panel insets. State how layouts adapt to different device sizes, orientations, and system text scaling.

### Icons and imagery

Icons must have screen-reader labels and recognizable silhouettes. State any requirements around third-party imagery (attribution, proportions, licensing) if the app displays externally sourced images — see [external integration](api.md).

## Component philosophy

Build the UI from a small set of internal, reusable primitives rather than composing ad hoc widgets everywhere. List the actual components as they're built, for example:

- `AppButton` — primary, secondary, and destructive variants with accessible touch targets.
- `AppPanel` — a reusable layered surface with consistent elevation, padding, and states.
- `AppDialog` — accessible confirmations and focused entry flows.

Components should expose semantic states and accessibility behavior; styling should be driven by the design tokens above rather than one-off values.

## Motion

Animation should communicate cause, state change, and hierarchy — it must never delay the user from acting. Define target durations for common motion categories:

| Motion | Target duration |
| --- | ---: |
| Immediate feedback | 120 ms |
| Standard transition | 250 ms |
| Page transition | 350 ms |

Reduced-motion mode should replace nonessential movement with fades or immediate state changes.

## Key layouts

Sketch the app's primary screens as low-fidelity text mockups so reviewers can align on layout before implementation:

```text
[Screen name]

[ Primary action ]

[Secondary content]
```

## Accessibility

Accessibility is part of the definition of done, not a later enhancement:

- screen-reader names, roles, values, and hints for every control;
- no color-only information;
- scalable text and reflow at supported system sizes;
- generous touch targets and spacing;
- reduced motion and high contrast support;
- confirmation or prominent undo for destructive actions.
