# ADR-001: Use Flutter as the application framework

## Status

Accepted

## Context

This project targets iOS and Android from a single codebase. Replace this section with the actual forcing function for your project: the platforms you need, the UI complexity you expect, offline requirements, and any alternative frameworks that were considered (for example, React Native, native platform SDKs, or a web-based shell).

## Decision

Build the application with Flutter and Dart. This repository is scaffolded as a Flutter template, so this decision is fixed at the template level; record any framework-adjacent choices your project makes on top of it (routing, rendering approach for custom UI, animation library) here or in a follow-up ADR.

## Consequences

- Android and iOS share one codebase and a consistent rendering model.
- Contributors need Flutter and Dart expertise, and platform-specific integration still requires native testing.
- The UI must retain mobile accessibility and conventions regardless of how custom its styling becomes.
- Update this section with the actual consequences your team observes as the project grows.

