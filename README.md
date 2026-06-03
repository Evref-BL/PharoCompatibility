[![Pharo version](https://img.shields.io/badge/Pharo-12%20%7C%2013%20%7C%2014-%23aac9ff.svg)](https://github.com/pharo-project/Pharo)
![Build Info](https://github.com/Evref-BL/PharoCompatibility/workflows/CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/PharoCompatibility/badge.svg?branch=main)](https://coveralls.io/github/Evref-BL/PharoCompatibility?branch=main)

# PharoCompatibility

PharoCompatibility is a small compatibility surface library for Pharo projects that need to keep loading while APIs move between Pharo versions.

Load the surface that matches the Pharo API your project source expects.

## Compatibility Matrix

Cells show cross-version compatibility. Same-version cells are left blank because no compatibility action is needed there.

| Surface | Pharo 12 | Pharo 13 | Pharo 14 |
| --- | :---: | :---: | :---: |
| `Pharo12Surface` |  | ~ | ~ |
| `Pharo13Surface` | ~ |  | ~ |

`✓` means supported. `~` means tested partial support: the surface restores selected equivalent APIs, not the whole source Pharo version. A blank cell means no compatibility shim is currently advertised.

## Installation

Add the surface your project needs to its baseline:

```smalltalk
spec
  baseline: 'PharoCompatibility'
  with: [
    spec
      repository: 'github://Evref-BL/PharoCompatibility:main/src';
      loads: #( 'Pharo12Surface' ) ]
```

Use `Pharo13Surface` instead when your source expects the Pharo 13 API. Require `PharoCompatibility` from packages that use its API:

```smalltalk
spec
  package: 'MyProject-Core'
  with: [ spec requires: #( 'PharoCompatibility' ) ]
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

To load the project directly:

```smalltalk
Metacello new
  githubUser: 'Evref-BL' project: 'PharoCompatibility' commitish: 'main' path: 'src';
  baseline: 'PharoCompatibility';
  load
```

Or load a surface directly:

```smalltalk
Metacello new
  githubUser: 'Evref-BL' project: 'PharoCompatibility' commitish: 'main' path: 'src';
  baseline: 'PharoCompatibility';
  load: 'Pharo13Surface'
```

## Compatibility Surface

The Pharo 12 surface currently provides:

- `SyntaxErrorNotification` mapped to the available syntax error notice class.
- `RBPullUpInstanceVariableRefactoring` mapped to the replacement refactoring class.
- `RBPushDownInstanceVariableRefactoring` mapped to the replacement refactoring class.
- A minimal `Author` compatibility class when `Author` is no longer present.

The Pharo 13 surface currently provides:

- `OCSyntaxErrorNotice` mapped to the available syntax error notice class.
- `RePullUpInstanceVariableRefactoring` mapped to the available pull-up refactoring class.
- `FileStream` mapped to the available standard I/O class when needed.
- `IceBranchAlreadyExists` mapped to `IceBranchAlreadyExistsError` when needed.
- `EpMonticelloVersionSave` and `EpMonticelloVersionsLoad` on Pharo 14.
- `MetacelloProjectRegistry>>registrationForClassNamed:ifAbsent:` on Pharo 14.
- A Pharo 13-compatible `ReClassRepackagingChange>>generateChanges` behavior on Pharo 14.

You can also install the surface explicitly from code:

```smalltalk
PharoCompatibility installPharo12Surface
PharoCompatibility installPharo13Surface
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

The repository also includes a smalltalkCI configuration. CI loads the `Tests` group and runs the loaded test packages on Pharo 12, Pharo 13, and Pharo 14:

```sh
smalltalkci -s Pharo64-12
smalltalkci -s Pharo64-13
smalltalkci -s Pharo64-14
```
