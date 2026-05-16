# Class Installer Facade Plan

## Goal

Provide a PharoCompatibility facade for class creation and class-definition updates that lets projects develop against one stable API while running on Pharo 11, 12, and 13. The first consumer is Pharo MCP, whose edit-class tools currently depend on class installer behavior that changed substantially across these versions.

## Problem

The class installation surface is not a small selector rename. The differences include class builders/installers, trait and class-trait installation, slot migration, layout handling, class-side state, package and tag categorization, and warning/error behavior during refactorings. Compatibility should therefore be a facade with version adapters, not scattered aliases.

## Proposed API

Add a small public API in `PharoCompatibility-Core`:

- `PharoCompatibility classInstaller`
- `PharoCompatibility installClass: aClassDefinition`
- `PharoCompatibility updateClass: aClassUpdate`

Add DTO-style objects for requests and results:

- `PharoCompatibilityClassDefinition`
- `PharoCompatibilityClassUpdate`
- `PharoCompatibilityClassInstallResult`
- `PharoCompatibilityClassInstallerWarning`

The request objects should describe intent using stable names:

- class name and superclass
- package and tag
- instance slots and class slots
- instance traits and class traits
- shared variables and shared pools
- layout class
- class comment

Adapters translate those stable requests to the image-specific class installer/refactoring API.

## Adapter Shape

Use one selector-facing facade with version-specific implementations selected at runtime:

- `PharoCompatibilityClassInstallerFacade`
- `PharoCompatibilityClassInstallerPharo11`
- `PharoCompatibilityClassInstallerPharo12`
- `PharoCompatibilityClassInstallerPharo13`

Adapters must avoid compile-time references to version-specific globals. Resolve installer, layout, trait, and refactoring classes through `Smalltalk at:ifAbsent:` or helper lookup methods.

## Scope

Phase 1 should cover the class operations Pharo MCP needs:

- create a class with full definition fields
- replace slots and class slots
- replace traits and class traits
- replace shared variables and shared pools
- replace layout
- change superclass
- move package/tag
- change class comment

Phase 2 should cover slot refactorings:

- add slot
- remove slot
- rename slot
- pull up slot
- push down slot

Phase 3 should adapt Pharo MCP to use the facade and remove direct assumptions about the active class installer.

## Validation

Build the tests as compatibility-contract tests, not as implementation tests:

- the same class definition creates equivalent class state on Pharo 11, 12, and 13
- repeated installs are idempotent where the platform allows it
- slot replacement preserves expected class-side state
- trait and class-trait replacement report stable names
- package/tag movement produces the same package metadata shape
- unsupported operations fail with structured, version-independent errors

Use small disposable fixture classes and remove them in `tearDown`.

## Risks

Class migration can crash older VMs when exercising incompatible trait or installer paths. The first implementation should isolate one operation per fresh image while the adapter contract is being discovered.

The facade should not hide semantic differences by silently dropping requested fields. If a version cannot perform an operation safely, it should answer a structured unsupported-operation error.

## Discovery Checklist

Before implementation, record the available installer/refactoring selectors in fresh Pharo 11, 12, and 13 images:

- class builder entry points
- slot and class-slot mutation APIs
- trait/class-trait mutation APIs
- layout replacement APIs
- package/tag categorization APIs
- warning classes signaled during class migration
- recovery paths after failed class installation
