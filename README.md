[![Pharo version](https://img.shields.io/badge/Pharo-12%20%7C%2013-%23aac9ff.svg)](https://github.com/pharo-project/Pharo)
![Build Info](https://github.com/Evref-BL/PharoCompatibility/workflows/CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/PharoCompatibility/badge.svg?branch=main)](https://coveralls.io/github/Evref-BL/PharoCompatibility?branch=main)

# PharoCompatibility

PharoCompatibility is a small compatibility surface library for Pharo projects that need to keep running while APIs move between Pharo versions.

The current surfaces help code written against Pharo 12 load on Pharo 13 or newer, and help code developed against the Pharo 13 surface remain loadable on Pharo 12 where equivalent APIs can be restored.

## Installation

PharoCompatibility is usually useful as a dependency of another project.

To add the Pharo 12 compatibility surface to your baseline:

```smalltalk
spec
  baseline: 'PharoCompatibility'
  with: [
    spec
      repository: 'github://Evref-BL/PharoCompatibility:main/src';
      loads: #( 'Pharo12Surface' ) ]
```

Then require it from packages that use the compatibility API:

```smalltalk
spec
  package: 'MyProject-Core'
  with: [ spec requires: #( 'PharoCompatibility' ) ]
```

The `Pharo12Surface` group loads the core package on Pharo 12 and also loads the Pharo 13 compatibility surface package on Pharo 13 or newer.

To develop against the Pharo 13 surface while keeping a project loadable on Pharo 12, load `Pharo13Surface` instead:

```smalltalk
spec
  baseline: 'PharoCompatibility'
  with: [
    spec
      repository: 'github://Evref-BL/PharoCompatibility:main/src';
      loads: #( 'Pharo13Surface' ) ]
```

If you only need the core helper API, omit the `loads:` line:

```smalltalk
spec
  baseline: 'PharoCompatibility'
  with: [
    spec repository:
      'github://Evref-BL/PharoCompatibility:main/src' ]
```

You can replace `main` with another branch or a release tag.

To load the project directly into a Pharo image:

```smalltalk
Metacello new
  githubUser: 'Evref-BL' project: 'PharoCompatibility' commitish: 'main' path: 'src';
  baseline: 'PharoCompatibility';
  load
```

Load the Pharo 12 compatibility surface directly when a project still expects those APIs:

```smalltalk
Metacello new
  githubUser: 'Evref-BL' project: 'PharoCompatibility' commitish: 'main' path: 'src';
  baseline: 'PharoCompatibility';
  load: 'Pharo12Surface'
```

## Compatibility Surface

The Pharo 12 surface currently provides:

- `SyntaxErrorNotification` mapped to the available syntax error notice class.
- `RBPullUpInstanceVariableRefactoring` mapped to the replacement refactoring class.
- `RBPushDownInstanceVariableRefactoring` mapped to the replacement refactoring class.
- A minimal `Author` compatibility class when `Author` is no longer present.

You can also install the surface explicitly from code:

```smalltalk
PharoCompatibility installPharo12Surface
```

## Usage

Use the helpers when writing code that should stay quiet across supported Pharo versions:

```smalltalk
PharoCompatibility syntaxErrorNoticeClassName.

PharoCompatibility
  resumeDeprecationsDuring: [ self loadLegacyCode ].

PharoCompatibility
  withNonInteractiveAuthorNamed: 'MyProject'
  during: [ self importSources ]
```

## Testing

Load the `Tests` group to get the common tests plus the surface-specific test package for the current Pharo version:

```smalltalk
Metacello new
  baseline: 'PharoCompatibility';
  repository: 'github://Evref-BL/PharoCompatibility:main/src';
  load: 'Tests'
```

The repository also includes a smalltalkCI configuration. CI loads the `Tests` group and runs the loaded test packages on Pharo 12 and Pharo 13:

```sh
smalltalkci -s Pharo64-12
smalltalkci -s Pharo64-13
```
