"
Tests for the Pharo 13 surface restored on Pharo 14.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo14Test',
	#superclass : 'PharoCompatibilityP13SurfaceTest',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo14-Tests-Tests',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo14-Tests',
	#tag : 'Tests'
}

{ #category : 'private' }
PharoCompatibilityP13SurfacePharo14Test >> removeClassNamed: aClassName [

	| classSymbol |
	classSymbol := aClassName asSymbol.
	(Smalltalk globals includesKey: classSymbol) ifTrue: [
		(Smalltalk globals at: classSymbol) removeFromSystem ]
]

{ #category : 'private' }
PharoCompatibilityP13SurfacePharo14Test >> removePackageNamed: aPackageName [

	(PackageOrganizer default hasPackage: aPackageName) ifTrue: [
		PackageOrganizer default removePackage: aPackageName ]
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testDebuggerMethodImplementorForSession [

	self
		assert: (PharoCompatibility debuggerMethodImplementorForSession: nil) class
		equals: StDebuggerMethodImplementor
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testInstallPharo13SurfacePreservesP13Globals [

	self assertPharo13SurfacePreservesP13Globals
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testInstallPharo13SurfaceProvidesLegacyIceBranchException [

	PharoCompatibility installPharo13Surface.
	self assert: (Smalltalk includesKey: #IceBranchAlreadyExists).
	self
		assert: (Smalltalk at: #IceBranchAlreadyExists)
		equals: (Smalltalk at: #IceBranchAlreadyExistsError)
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testMetacelloRegistryUnderstandsRegistrationForClassNamed [

	| registration |
	PharoCompatibility installPharo13Surface.
	registration := MetacelloProjectRegistration registry
		registrationForClassNamed: #BaselineOfPharoCompatibility
		ifAbsent: [ nil ].
	self assert: registration notNil.
	self
		assert: registration projectName asString
		equals: 'PharoCompatibility'
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testMoveClassRefactoringUsesTheClassBeingRepackaged [

	| className packageName targetClass |
	className := #PharoCompatibilityP14MoveProbe.
	packageName := 'PharoCompatibility-P14-MoveProbe'.
	[
	self removeClassNamed: className.
	self removePackageNamed: packageName.
	targetClass := (Object << className)
		package: 'PharoCompatibility-Tests';
		tag: 'Tests';
		install.
	(PackageOrganizer default ensurePackage: packageName) ensureTag:
		'Moved'.
	(RBMoveClassTransformation
		move: className
		toPackage: packageName
		inTag: 'Moved') execute.
	self
		assert: targetClass packageName asString
		equals: packageName.
	self assert: targetClass packageTagName asString equals: 'Moved' ]
		ensure: [
			self removeClassNamed: className.
			self removePackageNamed: packageName ]
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testPharo13ContextTempNamesSelector [

	| names temporaryValue |
	temporaryValue := 42.
	names := thisContext tempNames collect: [ :each | each asString ].
	self assert: (names includes: 'temporaryValue')
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testRefactoringChangeManagerClass [

	self assert: PharoCompatibility refactoringChangeManagerClass equals: ReChangeManager
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testSyntaxErrorNoticeClassName [

	self
		assert: PharoCompatibility syntaxErrorNoticeClassName
		equals: #OCSyntaxErrorNotice
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testSyntaxNoticeFromCodeError [

	| compiler notice |
	compiler := SmalltalkImage current compiler.
	compiler compilationContext isScripting: true.
	[ compiler evaluate: '1 +' ]
		on: Exception
		do: [ :error |
			notice := PharoCompatibility syntaxNoticeFromException: error ].
	self assert: notice notNil.
	self assert: notice class name equals: #OCSyntaxErrorNotice
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo14Test >> testUndeclaredVariableNodeFromCompilationError [

	| node |
	[
	Object compile:
		'pharoCompatibilityBrokenMethod ^ missingCompatibilityVariable' ]
		on: Exception
		do: [ :error |
			node := PharoCompatibility undeclaredVariableNodeFromException:
				        error ].
	self assert: node notNil.
	self assert: node name equals: #missingCompatibilityVariable
]
