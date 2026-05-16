# Roadmap Notes

## Pharo Surface Migration

PharoCompatibility should model compatibility by Pharo API surface, not by consuming project. A project declares the Pharo version it is written against by loading the matching surface group.

- A Pharo 12 project loads `Pharo12Surface`.
  - On Pharo 12 this is mostly no-op.
  - On Pharo 13 it loads shims that preserve the Pharo 12 API surface.
- A migrated Pharo 13 project should load `Pharo13Surface`.
  - On Pharo 13 this is mostly no-op.
  - On Pharo 12 it loads backward shims that preserve the Pharo 13 API surface.

PharoCompatibility can also grow migration tools that audit and rewrite a project from one surface to another. For MCP, the desired path is to keep the current `Pharo12Surface` support green, add `Pharo13Surface`, add P13-to-P12 shims, audit MCP, migrate MCP to the P13 surface, then verify MCP on both P13 and P12 through the compatibility layer.
