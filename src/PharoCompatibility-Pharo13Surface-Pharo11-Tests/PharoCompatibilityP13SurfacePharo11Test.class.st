"
Tests for the Pharo 13 surface restored on Pharo 11.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo11Test',
	#superclass : 'PharoCompatibilityP13SurfaceTest',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo11-Tests-Tests',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo11-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfacePreservesP13Globals [

	self assertPharo13SurfacePreservesP13Globals
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesP11PackageOrganizerCompatibility [

	PharoCompatibility installPharo13Surface.
	self assert: (Smalltalk at: #PackageOrganizer) equals: RPackageOrganizer.
	self assert: (PackageOrganizer default respondsTo: #hasPackage:).
	self assert: (PackageOrganizer default respondsTo: #ensurePackage:).
	self assert: (PackageOrganizer default respondsTo: #removePackage:).
	self assert: (PackageOrganizer default respondsTo: #packageNamed:ifPresent:).
	self assert:
		((PackageOrganizer default packageNamed: #'PharoCompatibility-Core')
			 respondsTo: #ensureTag:).
	self assert: (Object new respondsTo: #packageOrganizer).
	self
		assert: (PackageOrganizer default
				 packageNamed: #'PharoCompatibility-Core'
				 ifPresent: [ :package | package name asString ])
		equals: 'PharoCompatibility-Core'.
	self
		assert: (PackageOrganizer default
				 packageNamed: #'PharoCompatibility-Missing-Package'
				 ifPresent: [ :package | package name ])
		equals: nil
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesP11PackageMetadataCompatibility [

	| package |
	PharoCompatibility installPharo13Surface.
	package := PackageOrganizer default packageNamed:
		           #'PharoCompatibility-Core'.
	self assert: PharoCompatibility packageName asString equals: 'PharoCompatibility-Core'.
	self assert: PharoCompatibility packageTagName asString equals: 'Core'.
	self assert: package name asString equals: 'PharoCompatibility-Core'.
	self deny: package isUndefined.
	self assert: ((package tagNames collect: #asString) includes: 'Core')
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesLiteralEmptyClassComments [

	| className createdClass packageName |
	PharoCompatibility installPharo13Surface.
	className := #PharoCompatibilityP11CommentProbe.
	packageName := 'PharoCompatibility-Temp-Comments'.
	[
	(Smalltalk globals includesKey: className) ifTrue: [
		(Smalltalk globals at: className) removeFromSystem ].
	createdClass := (Object << className)
		                package: packageName;
		                install.
	createdClass comment: 'temporary comment'.
	createdClass comment: ''.
	self assert: createdClass comment equals: '' ] ensure: [
		(Smalltalk globals includesKey: className) ifTrue: [
			(Smalltalk globals at: className) removeFromSystem ].
		(PackageOrganizer default hasPackage: packageName) ifTrue: [
			PackageOrganizer default removePackage: packageName ] ]
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesP11TaggedClassBuilderCompatibility [

	| className createdClass packageName tagName |
	PharoCompatibility installPharo13Surface.
	className := #PharoCompatibilityP11TaggedBuilderFixture.
	packageName := 'PharoCompatibility-Temp-Tagged-Builder'.
	tagName := 'Generated'.
	[
	(Smalltalk globals includesKey: className) ifTrue: [
		(Smalltalk globals at: className) removeFromSystem ].
	(PackageOrganizer default hasPackage: packageName) ifTrue: [
		PackageOrganizer default removePackage: packageName ].
	createdClass := PharoCompatibilityClassInstaller
		                createSubclassOf: Object
		                named: className
		                package: packageName
		                tag: tagName
		                slots: #(  )
		                classSlots: #(  )
		                traits: #(  )
		                classTraits: #(  )
		                sharedVariables: #(  )
		                sharedPools: #(  )
		                layout: nil.
	self assert: (PackageOrganizer default hasPackage: packageName).
	self assert: createdClass packageName asString equals: packageName.
	self assert: createdClass packageTagName asString equals: tagName.
	self
		assert:
			((PackageOrganizer default packageNamed: packageName asSymbol)
				 hasTag: tagName).
	self
		assert:
			(((PackageOrganizer default packageNamed: packageName asSymbol)
				  tagNames collect: #asString) includes: tagName) ] ensure: [
		(Smalltalk globals includesKey: className) ifTrue: [
			(Smalltalk globals at: className) removeFromSystem ].
		(PackageOrganizer default hasPackage: packageName) ifTrue: [
			PackageOrganizer default removePackage: packageName ] ]
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesP11RefactoringCompatibility [

	PharoCompatibility installPharo13Surface.
	self
		assert: (Smalltalk at: #ReRemoveClassRefactoring)
		equals: RBRemoveClassRefactoring.
	self
		assert: (Smalltalk at: #ReRemoveInstanceVariableRefactoring)
		equals: RBRemoveInstanceVariableRefactoring.
	self
		assert: (Smalltalk at: #ReRenameClassRefactoring)
		equals: RBRenameClassRefactoring.
	self
		assert: (Smalltalk at: #ReRenameMethodRefactoring)
		equals: RBRenameMethodRefactoring.
	self assert: (Smalltalk includesKey: #ReRemoveMethodsRefactoring).
	self assert:
		(RBMoveClassTransformation class includesSelector: #move:toPackage:).
	self assert:
		(RBMoveClassTransformation class includesSelector: #move:toPackage:inTag:).
	self assert:
		(ReRemoveMethodsRefactoring class includesSelector: #selectors:from:).
	self assert:
		(RBRemoveClassRefactoring canUnderstand: #prepareForExecution).
	self assert:
		(RBRemoveClassRefactoring canUnderstand: #removeClassChanges).
	self assert:
		(RBRemoveMethodRefactoring canUnderstand: #removeMethodChanges).
	self assert:
		(ShiftClassBuilder canUnderstand: #fillInstanceSideFromClass:).
	self assert:
		(ShiftClassBuilder canUnderstand: #fillClassSideFromEnvironment:).
	self assert: (ShiftClassBuilder canUnderstand: #install).
	self assert: (ShiftClassBuilder canUnderstand: #layout:).
	self assert: (ShiftClassBuilder canUnderstand: #sharedPools:).
	self assert: (ShiftClassBuilder canUnderstand: #traits:).
	self assert: (ShiftClassBuilder canUnderstand: #classTraits:).
	self assert:
		(PharoCompatibilityClassInstaller class
			 includesSelector:
			 #createSubclassOf:named:package:tag:slots:classSlots:traits:classTraits:sharedVariables:sharedPools:layout:).
	self assert:
		(PharoCompatibilityClassInstaller class includesSelector: #update:to:).
	self assert:
		(PharoCompatibilityClassInstaller class
			 includesSelector: #reparent:toSuperclass:).
	self assert:
		(CompilationContext canUnderstand: #isScripting:).
	self assert: #tests name equals: #tests
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesLegacyFileStreamBinding [

	self assertPharo13SurfaceProvidesLegacyFileStreamBinding
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesMillisecondSemaphoreTimeout [

	self assertPharo13SurfaceProvidesMillisecondSemaphoreTimeout
]
