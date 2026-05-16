[![Pharo version](https://img.shields.io/badge/Pharo-12%20%7C%2013-%23aac9ff.svg)](https://github.com/pharo-project/Pharo)
![Build Info](https://github.com/Evref-BL/PharoCompatibility/workflows/CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/PharoCompatibility/badge.svg?branch=main)](https://coveralls.io/github/Evref-BL/PharoCompatibility?branch=main)

# PharoCompatibility

PharoCompatibility is a small compatibility surface library for Pharo projects that need to keep running while APIs move between Pharo versions.

The current surface helps code written against Pharo 12 load on Pharo 13 or newer by restoring a few removed or renamed globals and authoring protocols.

## Installation

Load the default group with Metacello:

```smalltalk
Metacello new
  githubUser: 'Evref-BL' project: 'PharoCompatibility' commitish: 'main' path: 'src';
  baseline: 'PharoCompatibility';
  load
```

Load the Pharo 12 compatibility surface when a project still expects those APIs:

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

Run the tests from a loaded image:

```smalltalk
PharoCompatibilityTest suite run
```

The repository also includes a smalltalkCI configuration. CI runs the test package on Pharo 12 and Pharo 13:

```sh
smalltalkci -s Pharo64-12
smalltalkci -s Pharo64-13
```
