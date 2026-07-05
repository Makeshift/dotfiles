---
description: These instructions should be followed when working with a TypeScript project in any repository.
applyTo: 'Typescript or Pulumi'
---

## General Principles
- Strive for DRY - Create generic solutions and utilities and ensure you check the codebase for existing patterns that can be reused rather than writing new ones.
- Avoid duplication of structure between runtime validators and interfaces unless needed purely for richer IntelliSense/JSDoc.
- Provide precise inferred types when merging fragments 
- Never use `any` or `unknown`. If flexibility is required, define constrained generics or explicit discriminated unions.
- Prefer enums (or literal unions) for documented finite sets. Do not widen with patterns like `Enum | string` unless truly open-ended.
- Avoid patterns that cause type widening (e.g. `MyEnum | string` or `string | number` when a narrower discriminated union is possible).
- Enforce strong typing for IDs, ARNs, regions, etc. via branded types or template literal types when helpful.
- When producing large numbers of types, utilise namespaces (e.g. `enum`, `runtime`, `types`) to group logically related constructs and avoid polluting the top-level scope.

## Documentation & IntelliSense
- Add well-formed JSDoc for functions, methods, classes, enum members and members of configuration objects.
- Provide usage examples sparingly; prefer inline JSDoc examples using `@example` style without executing side effects.
- Ensure naming clarity: avoid abbreviations unless ubiquitous (e.g. `ARN`); prefer descriptive property names.

## Code Style (ts-standard aligned)
- 2-space indentation, no semicolons, single quotes. Add trailing commas where possible.
- Avoid unused exports and dead code; examples should be opt‑in or placed in separate non-exported sections/files.
- Maintain consistent PascalCase for types/interfaces/enums; camelCase for functions and variables.

- Keep inputs strongly typed; use `pulumi.Input<T>` / `pulumi.Output<T>` patterns where needed in Pulumi programs. 
- Avoid embedding business logic (e.g., parsing ARNs) repeatedly; centralize helper utilities (e.g., `parseArn()`).
- Do not introduce side-effectful resource creation in pure type/schema modules.

## Error Handling
- Provide explicit runtime guards (`isX(value)`) utilizing validator assertions for safer narrowing.
- Avoid silent failures; throw descriptive errors.

## Versioning & Extensibility
- Add TODO/JSDoc notes where an external spec is incomplete or expected to expand (include link to authoritative source)

## Examples
- Keep examples free of side effects and non-exported to avoid unused variable lint issues.
- Prefer concise examples illustrating construction, composition, and validation rather than full application flows.
